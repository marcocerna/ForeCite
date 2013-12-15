class Book < ActiveRecord::Base
  # This was lifted straight from Booklust.

  #################################
  # Step 1: Request to Amazon API #
  #################################


  def amazon_request(number)

    puts "Amazon request method has fired"
    # Sets up params hash with ISBN and all the other stuff Amazon needs
    current_time = DateTime.now.utc.strftime("%FT%TZ")
    isbn = number.gsub(/[^0-9]/, "")
    params = {
            "Service" => "AWSECommerceService",
            "AWSAccessKeyId" => ENV['AMAZON_KEY'],
            "AssociateTag" => ENV['AMAZON_ASSOCIATE_TAG'],
            "Condition" => "All",
            "IdType" => "ISBN",
            "ItemId" => isbn,
            "Operation" => "ItemLookup",
            "ResponseGroup" => "ItemAttributes,Images,Reviews",
            "SearchIndex" => "Books",
            "Version" => "2009-01-06",
            "Timestamp" => current_time
            }

    # Sets up those params in a string that includes http verb and API endpoint (and whatever onca/xml is)
    secret_key = ENV['AMAZON_SECRET']
    data = ['GET', 'webservices.amazon.com', '/onca/xml', params.to_query].join("\n")

    # Generates sha and signature (these classes? are built into Ruby or maybe Rails)
    sha256 = OpenSSL::Digest::SHA256.new
    sig = OpenSSL::HMAC.digest(sha256, secret_key, data)
    signature = Base64.encode64(sig)
    signature_hash = { "Signature" => signature }
    request_url = "http://webservices.amazon.com/onca/xml?"

    # This is the final thing we're gonna need for the API request
    formatted_request = request_url + params.to_query + "&" + signature_hash.to_query.chomp.gsub(/%0A/,'')


    puts "Here is the formatted_request: "
    p formatted_request

    # Typhoeus request
    request = Typhoeus.get(formatted_request).body
    puts "Amazon request method has completed"
    p request


  end



  ###################################################
  # Step 2: Parse that data with Nokogiri and Xpath #
  ###################################################


  # Now that we've run the request, we have Nokogiri parse the amazon data into an XML object
  def parse_request(number)
    puts "Parse request method has fired"
    request = Nokogiri::XML(amazon_request(number))
    puts "Parse request method has completed"

    request.remove_namespaces!

  end


  # This will let us grab multiple ISBNs and run API calls on all of them
  def batch_requests(array)
    puts "Batch requests method has fired"
    all_books = []
    count = 0

    array.each do |isbn|
      return all_books if count == 5

      amazon_data = {}
      request = parse_request(isbn)

      # Check for throttle
        # if so, log an error
      image = request.xpath("//LargeImage").text.split(".jpg")[0] + ".jpg"
      title = request.xpath("//Title").text
      link = request.xpath("//ItemLink").first.children.last.text

      amazon_data[:image] = image
      amazon_data[:title] = title
      amazon_data[:link] = link

      all_books.push(amazon_data)


      sleep(1)
      count += 1
    end

    puts "Batch requests method has completed"
    all_books
  end

end
