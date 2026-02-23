# config/initializers/devise_secret_key.rb
if Rails.env.production?
  # Directly set Devise secret key from environment variable
  Devise.setup do |config|
    config.secret_key = ENV['DEVISE_SECRET_KEY']
  end

  # Also set Rails secret key base
  Rails.application.config.secret_key_base = ENV['SECRET_KEY_BASE']
end
