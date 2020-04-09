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

    end
  end
end