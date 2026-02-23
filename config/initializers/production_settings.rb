# config/initializers/production_settings.rb
if Rails.env.production?
  # Set Devise secret key
  Devise.secret_key = ENV['DEVISE_SECRET_KEY']

  # Ensure ActiveRecord Encryption is fully disabled
  ActiveRecord::Encryption.encrypt = false if defined?(ActiveRecord::Encryption)
end
