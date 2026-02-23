# config/initializers/active_record_encryption.rb
# This runs AFTER load_defaults, which is what we want

if Rails.env.production?
  # First, make sure encryption is enabled (it should be by default)
  # Then configure it with dummy keys
  Rails.application.config.after_initialize do
    if defined?(ActiveRecord::Encryption)
      ActiveRecord::Encryption.configure(
        primary_key: ENV['ACTIVE_RECORD_ENCRYPTION_PRIMARY_KEY'] || ("a" * 32),
        deterministic_key: ENV['ACTIVE_RECORD_ENCRYPTION_DETERMINISTIC_KEY'] || ("b" * 32),
        key_derivation_salt: ENV['ACTIVE_RECORD_ENCRYPTION_KEY_DERIVATION_SALT'] || ("c" * 32)
      )
    end
  end
end
