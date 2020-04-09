module ActionHook
  module Core
    class Request
      attr_accessor :url, :method, :body

      def initialize(url:, method: :post, body: nil, headers: nil)
        @url = url
        @method = method
        @body = body
        @headers = headers
      end

      def serialized_body
        @body
      end

    end
  end
end