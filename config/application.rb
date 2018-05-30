require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module GympassGrandprix
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Don't generate system test files.
    config.generators.system_tests = nil
    config.generators do |g|
      g.test_framework :rspec, :view_specs => false,
                               :controller_specs => false,
                               :helper_specs => false,
                               :routing_specs => false,
                               :request_specs => false
    end

    config.active_record.default_timezone = :local
    config.i18n.default_locale = "pt-BR"
    config.time_zone = 'Brasilia'



    # Settings to permit all params in methods
    config.action_controller.permit_all_parameters = true
  end
end
