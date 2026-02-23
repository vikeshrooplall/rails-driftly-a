require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RailsDriftlyAirbnb
  class Application < Rails::Application
    config.before_initialize do
      if Rails.env.production?
        ENV['SECRET_KEY_BASE'] ||= ENV['RAILS_MASTER_KEY']
        Devise.secret_key = ENV['DEVISE_SECRET_KEY'] if defined?(Devise)
      end
    end

    # IMPORTANT: Configure encryption BEFORE load_defaults
    # but don't set encryption = false yet
    if Rails.env.production?
      # First configure encryption with dummy values
      config.active_record.encryption.primary_key = "0" * 32
      config.active_record.encryption.deterministic_key = "0" * 32
      config.active_record.encryption.key_derivation_salt = "0" * 32

      # Then disable it
      config.active_record.encryption = false
    end

    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.1

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w(assets tasks))

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
