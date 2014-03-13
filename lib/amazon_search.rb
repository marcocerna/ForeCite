module AmazonSearch

  def amazon_book_search(query)
    # Sets up params hash with ISBN and all the other stuff Amazon needs
    current_time = DateTime.now.utc.strftime("%FT%TZ")
    query = query.split(" ").join("_")

    params = {
            "Service" => "AWSECommerceService",
            "AWSAccessKeyId" => ENV['AMAZON_KEY'],
            "AssociateTag" => ENV['AMAZON_ASSOCIATE_TAG'],
            "Condition" => "All",
            "Keywords" => query,
            "Operation" => "ItemSearch",
            "ResponseGroup" => "Images,ItemAttributes",
            "SearchIndex" => "Books",
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

    # Typhoeus request
    request = Typhoeus.get(formatted_request).body

    ##############
    # Formatting #
    ##############

    parsed = Nokogiri::XML(request).remove_namespaces!
    images = parsed.xpath("//LargeImage")
    titles = parsed.xpath("//Title")
    links = parsed.xpath("//DetailPageURL")

    image_array = []
    title_array = []

    attributes = []

    images.each do |image|
      link = image.text.split(".jpg")
      image_array << link[0] + ".jpg"
    end

    image_array.uniq!

    titles.each do |title|
      title_array << title.text
    end

    for i in (0..4)
      attributes << {title: title_array[i], image: image_array[i], link: links[i].text}
    end

    attributes

  end

end