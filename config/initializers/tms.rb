if Rails.env.production?
	Tvnexthack::Application.config.tms_api_key = ENV['TMS_API_KEY']
else
	require "#{Rails.root}/settings"
	Tvnexthack::Application.config.tms_api_key = TMS_API_KEY
end