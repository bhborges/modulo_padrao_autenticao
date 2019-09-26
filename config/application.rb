require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Seletivofuvest
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Brasilia'
    config.active_record.default_timezone = :local

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    config.i18n.default_locale = 'pt-BR'

    # Use Vips for processing variants.
    config.active_storage.variant_processor = :vips

    # Rails generate without helpers
    config.generators.helper = false

    # Rails generate without jbuilder files
    config.generators.jbuilder = false

    # Rails generate without system tests
    config.generators.system_tests = nil

    # Rails generate without decorators
    config.generators.decorator = nil

    # Include extend lib classes in initialize
    Dir[File.join(Rails.root, 'lib', 'core_ext', '*.rb')].each { |file| require file }
    # Dir[File.join(Rails.root, 'app', 'services', '*.rb')].each { |file| require file }

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
