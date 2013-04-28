require 'nokogiri'
require 'net/http'
require 'uri'

class IMDB
  class << self
    def find_actor(name)
      query = name.gsub(' ','+').downcase
      doc = Nokogiri::HTML(Net::HTTP.get(URI.parse("http://www.imdb.com/find?q=#{query}&s=nm")))
      link = doc.css(".findList .result_text a").first
      "http://www.imdb.com#{link['href']}"
    end
  end
end