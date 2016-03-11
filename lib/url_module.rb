require "uri"
require "net/http"
module UrlModule
  def self.url_encode(url)
  	uri = URI.encode(url)
  	return uri.gsub(".", "%2E");
  end
  def self.url_decode(url)
	  uri = URI.decode(url)
  	return uri.gsub("%2E", ".");
  end
  def self.getHttp(host)
	  sched_uri = URI.parse(host)
	  return Net::HTTP.new(sched_uri.host, sched_uri.port)
  end
end