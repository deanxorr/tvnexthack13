class GetGlue
  class << self
    BASE_URL = "http://api.getglue.com/v3/tv_shows/"
    TOKEN = Tvnexthack::Application.config.get_glue_token

    def get_stream_from_name(name)
      tms_title = Tms.tms_id(name)['title'].gsub(' ','_')
      query = "#{tms_title.downcase}/feed?"
      request(BASE_URL + query)['response']['interactions']
    end

    def request(url)
      puts "requesting #{url}"
      begin
        uri = URI.parse( url + token_string )
        f = JSON.parse( Net::HTTP.get(uri) )
      rescue => e
        puts "encountered #{e.inspect}. Bad URL was #{url}"
      end
    end

    def token_string
      "access_token=#{TOKEN}"
    end
  end
end