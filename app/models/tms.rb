require 'net/http'

class Tms
  API_KEY = Tvnexthack::Application.config.tms_api_key
  BASE_URL = "http://data.tmsapi.com/v1/"
  class << self
    def tms_id(series_name)
      query = "programs/search?"
      query << "q=#{series_name}&titleLang=en&descriptionLang=en&entityType=series"
      res = request(BASE_URL + query)
      res['hits'].select do |hit| 
        hit['program']['title'].downcase.match("#{series_name.downcase}")
      end[0]['program']
    end

    def next_showings(program)
      query = "series/#{program}/airings?"
      now = Time.now.strftime("%FT%H:%mZ")
      future = 2.days.from_now.strftime("%FT%H:%mZ")
      query << "lineupId=USA-TX42500-X&startDateTime=#{now}&endDateTime=#{future}"
      request(BASE_URL + query)
    end

    def series_details(program)
      query = "series/#{program}?"
      request(BASE_URL + query)
    end

    def request(url)
      puts "requesting #{url}"
      begin
        uri = URI.parse( url + api_string )
        f = JSON.parse( Net::HTTP.get(uri) )
      rescue => e
        puts "encountered #{e.inspect}. Bad URL was #{url}"
      end
    end

    def api_string
      "&api_key=#{API_KEY}"
    end
  end
end