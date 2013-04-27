if Rails.env.production?
	Tvnexthack::Application.config.get_glue_token = ENV['GET_GLUE_TOKEN']
else
	require "#{Rails.root}/settings"
Tvnexthack::Application.config.get_glue_token = GET_GLUE_TOKEN
end