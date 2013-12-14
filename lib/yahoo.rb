require 'oauth_util.rb'
require 'net/http'
require 'nokogiri'

module Yahoo

  def get_response(args,buckets)
      url = "http://yboss.yahooapis.com/ysearch/"+buckets+"?"
      arg_count = 0
      args.each do|key,value|
          url = url + key + "=" + value+"&"
          ++arg_count
      end

      if(arg_count > 0)
          url.slice!(url.length-1)
      end

      parsed_url = URI.parse( url )
      p parsed_url

      o = OauthUtil.new
      o.consumer_key = "dj0yJmk9cG1MSmJ2WEtVeHRRJmQ9WVdrOVRsUTFTelpQTldVbWNHbzlNQS0tJnM9Y29uc3VtZXJzZWNyZXQmeD03NQ--"
      o.consumer_secret = "5dc391f9ba9d323757ab8fbc2deb8a0822dfdb79"

      Net::HTTP.start( parsed_url.host ) { | http |
          req = Net::HTTP::Get.new "#{ parsed_url.path }?#{ o.sign(parsed_url).query_string }"
          response = http.request(req)
          return response.read_body
      }
  end

  def boss_call(query)
    args = Hash.new
    args["format"] = "xml"
    args["q"] = "wiki+" + query
    args["count"] = "10"

    buckets = "web"

    unparsed_response = get_response(args,buckets)
    parsed_response = Nokogiri::XML(unparsed_response)
    all_responses = parsed_response.children[0].children[0].children[0].children

    titles = []

    all_responses.each do |response|
      title = response.children[4].children.text
      titles << title if title.include? "Wikipedia"
    end

    titles
  end

  # binding.pry
end