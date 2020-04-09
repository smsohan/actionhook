module ActionHook
  module Core
    class Request
      attr_accessor :url, :method, :body, :headers, :secret

      def initialize(url:, method: :post, body: nil, headers: {}, secret: nil)
        @url = url
        @method = method
        @body = body
        @headers = headers || {}
        @secret = secret
      end

      def serialized_body
        @body
      end

      def uri
        @uri ||= URI.parse(url)
      end

      def headers_with_sha256_fingerprint
        if digest = fingerprint
          headers.merge(ActionHook.configuration.hash_header_name => digest)
        else
          headers
        end
      end

      def fingerprint
        if secret && serialized_body
          OpenSSL::HMAC.hexdigest(OpenSSL::Digest::SHA256.new, secret, serialized_body)
        end
      end


    end
  end
end