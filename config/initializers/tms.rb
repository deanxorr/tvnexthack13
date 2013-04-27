require "#{Rails.root}/settings" unless Rails.env.production?

Tvnexthack::Application.config.tms_api_key = TMS_API_KEY