require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Ycms
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.generators do |g|
	  g.test_framework :rspec,
	    :fixtures => true,
	    :view_specs => false,
	    :helper_specs => false,
	    :routing_specs => false,
	    :controller_specs => true,
	    :request_specs => true
	  g.fixture_replacement :factory_girl, :dir => "spec/factories"
	end

  config.i18n.default_locale = :ru

	config.languages = { en: "English", ru: "Русский" }
  config.page_size = 20

	# Include files from lib path
  config.autoload_paths += %W(#{config.root}/lib)

  config.time_zone = 'Moscow' 
  config.active_record.default_timezone = :local

  end
end
