# config/initializers/disable_activerecord_encryption.rb
if Rails.env.production?
  # Disable ActiveRecord Encryption completely
  ActiveRecord::Encryption.configure(
    primary_key: ENV['ACTIVE_RECORD_ENCRYPTION_PRIMARY_KEY'] || 'unused',
    deterministic_key: ENV['ACTIVE_RECORD_ENCRYPTION_DETERMINISTIC_KEY'] || 'unused',
    key_derivation_salt: ENV['ACTIVE_RECORD_ENCRYPTION_KEY_DERIVATION_SALT'] || 'unused',
    encrypt: false
  )

  # Or completely disable the encryption feature
  module ActiveRecord
    module Encryption
      def self.encrypt?
        false
      end
    end
  end
end
