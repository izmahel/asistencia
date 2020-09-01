require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Asistencia
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0
    config.i18n.default_locale = 'es-MX'
    config.time_zone = "America/Chihuahua"

    # Email Configuration
    config.action_mailer.raise_delivery_errors = true
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
        :address   => "smtp.gmail.com",
        :port      => 587,
        :domain    => "cimav.edu.mx",
        :authentication => :plain,
        :user_name      => "notificaciones@cimav.edu.mx",
        :password       => "N0t1f1c4c10n35@C1m4v!",
        :enable_starttls_auto => true
    }

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
