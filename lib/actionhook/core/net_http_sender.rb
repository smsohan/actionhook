require 'net/http'

module ActionHook

  module Core

    class NetHTTPSender

      def self.request_method_class(method)
        case method
        when :post then Net::HTTP::Post
        when :get then Net::HTTP::Get
        when :delete then Net::HTTP::Delete
        when :put then Net::HTTP::Put
        else raise ArgumentError, "Invalid method #{method} is used"
        end
      end

      def self.send(request, configuration = ActionHook.configuration)
        options = { use_ssl: request.uri.scheme == 'https' }.merge(configuration.net_http_options)

        Net::HTTP.start(request.uri.host, request.uri.port, options) do |http|
          http_request = request_method_class(request.method).new request.uri
          http_request.body = request.serialized_body if request.body

          request.headers_with_security&.each_pair do |name, value|
            http_request[name] = value.to_s
          end

          http.request http_request
        end

      end

    end

  end

end
