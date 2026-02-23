# config/initializers/production_settings.rb
if Rails.env.production?
  # Set Rails secret key base
  Rails.application.config.secret_key_base = ENV['SECRET_KEY_BASE']

  # Set Devise secret key - make sure it's a valid key
  if ENV['DEVISE_SECRET_KEY'].present?
    Devise.setup do |config|
      config.secret_key = ENV['DEVISE_SECRET_KEY']
    end
  end

  # Configure ActiveRecord Encryption with proper 32-byte keys
  if defined?(ActiveRecord::Encryption)
    ActiveRecord::Encryption.configure(
      primary_key: ENV['ACTIVE_RECORD_ENCRYPTION_PRIMARY_KEY'] || ("a" * 32),
      deterministic_key: ENV['ACTIVE_RECORD_ENCRYPTION_DETERMINISTIC_KEY'] || ("b" * 32),
      key_derivation_salt: ENV['ACTIVE_RECORD_ENCRYPTION_KEY_DERIVATION_SALT'] || ("c" * 32)
    )
  end
end
