require 'net/http'

module ActionHook

  module Core

    class NetHTTPSender

      def self.send(request, configuration = ActionHook.configuration)
        options = { use_ssl: request.uri.scheme == 'https' }.merge(configuration.net_http_options)

        Net::HTTP.start(request.uri.host, request.uri.port, options) do |http|
          method_class =
            case request.method
            when :post then Net::HTTP::Post
            when :get then Net::HTTP::Get
            when :delete then Net::HTTP::Delete
            when :put then Net::HTTP::Put
            else raise ArgumentError, "Invalid method #{request.method} is used"
            end

          http_request = method_class.new request.uri
          http_request.body = request.serialized_body if request.body

          request.headers&.each_pair do |name, value|
            http_request[name] = value.to_s
          end

          http.request http_request
        end

      end

    end

  end

end
