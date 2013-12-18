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

    query = query.split(" ").join("+")
    args = Hash.new
    args["q"] = "wiki+" + query
    buckets = "web"

    unparsed_object = get_response(args,buckets)
    parsed_object = JSON.parse(unparsed_object)
    parsed_results = parsed_object["bossresponse"]["web"]["results"]

    titles = []

    parsed_results.each do |result|
      title = result["title"]
      titles << title.split(" - ")[0] if title.include? "Wikipedia"
    end

    titles.uniq! if titles.length > 1
    titles
  end

end