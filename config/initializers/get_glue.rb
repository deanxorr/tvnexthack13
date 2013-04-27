require "#{Rails.root}/settings" unless Rails.env.production?

Tvnexthack::Application.config.get_glue_token = GET_GLUE_TOKEN