require 'net/http'

class TMS
  API_KEY = Tvnexthack::Application.config.tms_api_key
  BASE_URL = "http://data.tmsapi.com/v1/"

  def initialize(series_name)
    @name = series_name
  end

  def tms
    @tms ||= get_program(@name)
  end

  def program_id
    @program_id ||= tms['seriesId']
  end

  def id
    tms['tmsId']
  end

  def showings
    @showings ||= next_showings(program_id)
  end

  def details
    @details ||= series_details(program_id)
  end

  def parsed_showings
    showings.map {|showing| { :start => (Time.iso8601(showing['startTime'].gsub('Z',":00-00:00")) - 4.hours).strftime("%a, %b %e at %l:%M %p EST"), :station => showing['station']['callSign'] } }
  end

  def parsed_cast
    @cast ||= details['cast'].map do |member|
      { :name => member['name'], :character => member['characterName'] }
    end
  end

  def parsed_recommendations
    details['recommendations'].map { |rec| rec['title'] }
  end

  def attributes
    {
      :id => id,
      :showings => parsed_showings,
      :desc => details['shortDescription'],
      :cast => parsed_cast,
      :recommendations => parsed_recommendations
    }
  end

  def tms_id(series_name)
    @tms_id ||= get_program(series_name)
  end

  def next_showings(program)
    query = "series/#{program}/airings?"
    now = Time.now.strftime("%FT%H:%mZ")
    future = 1.day.from_now.strftime("%FT%H:%mZ")
    query << "lineupId=USA-TX42500-X&startDateTime=#{now}&endDateTime=#{future}"
    request(BASE_URL + query)
  end

  def program
    @program ||= series_details(program)
  end

  def series_details(program)
    query = "series/#{program}?"
    request(BASE_URL + query)
  end

  def get_program(series_name)
    name = series_name.gsub(' ','+')
    query = "programs/search?"
    query << "q=#{ name }&titleLang=en&descriptionLang=en&entityType=series"
    res = request(BASE_URL + query)
    res['hits'].select do |hit| 
      hit['program']['title'].downcase.match("#{series_name.downcase}")
    end[0]['program']
  end

  def request(url)
    puts "requesting #{url}"
    begin
      uri = URI.parse( url + api_string )
      f = JSON.parse( Net::HTTP.get(uri) )
    rescue => e
      puts "encountered #{e.inspect}. Bad URL was #{url + api_string}"
    end
  end

  def api_string
    "&api_key=#{API_KEY}"
  end
end