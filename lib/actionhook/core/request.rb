module ActionHook
  module Core
    class Request
      attr_accessor :url, :method, :body, :headers, :secret, :authentication

      def initialize(url:, method: :post, body: nil, headers: {}, secret: nil, authentication: nil)
        @url = url
        @method = method
        @body = body
        @headers = headers || {}
        @secret = secret
        @authentication = authentication
      end

      def serialized_body
        @body
      end

      def uri
        @uri ||= URI.parse(url)
      end

      def headers_with_security
        headers_with_security = headers.dup

        if digest = fingerprint
          headers_with_security.merge!(ActionHook.configuration.hash_header_name => digest)
        end

        headers_with_security.merge!(authentication.to_h) if authentication

        headers_with_security
      end

      def fingerprint
        if secret && serialized_body
          OpenSSL::HMAC.hexdigest(OpenSSL::Digest::SHA256.new, secret, serialized_body)
        end
      end

    end
  end
end