require_relative './fingerprinting'

module ActionHook
  module Security
    module Headers
      include ActionHook::Security::Fingerprinting

      def headers_with_security
        headers_with_security = headers.dup

        if digest = fingerprint
          headers_with_security.merge!(ActionHook.configuration.hash_header_name => digest)
        end

        headers_with_security.merge!(authentication.to_h) if authentication

        headers_with_security
      end

    end
  end
end