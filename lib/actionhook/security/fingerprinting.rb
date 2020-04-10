module ActionHook
  module Security
    module Fingerprinting

      def fingerprint
        if secret && serialized_body
          OpenSSL::HMAC.hexdigest(OpenSSL::Digest::SHA256.new, secret, serialized_body)
        end
      end

    end
  end
end