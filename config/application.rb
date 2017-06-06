require_relative 'boot'

require 'rails/all'

# Barcode generator
require 'barby'
require 'barby/barcode/code_128'
require 'barby/outputter/svg_outputter'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module BlueLily
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.time_zone = 'Pacific Time (US & Canada)'
    config.filepicker_rails.api_key = Rails.application.secrets.filepicker_api_key
  end
end
