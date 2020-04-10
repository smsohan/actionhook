require 'actionhook/security/headers'

module ActionHook
  module Core
    class Request
      include ActionHook::Security::Headers

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

    end
  end
end