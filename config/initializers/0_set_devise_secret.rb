# config/initializers/0_set_devise_secret.rb
# This runs before Devise's initializer
if Rails.env.production?
  # Set Devise secret key directly
  Devise.secret_key = ENV['DEVISE_SECRET_KEY']

  # Also set Rails secret key base
  Rails.application.config.secret_key_base = ENV['SECRET_KEY_BASE']

  # Disable credentials for Devise
  Devise.setup do |config|
    config.secret_key = ENV['DEVISE_SECRET_KEY']
  end
end
