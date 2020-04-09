module ActionHook
  module Core
    class Sender

      def deliver(request, configuration = ActionHook.configuration)

      end

    end

    class NetHTTPSender < Sender

      def deliver(request, configuration = ActionHook.configuration)
        uri = URI(request.url)

        Net::HTTP.start(uri.host, uri.port, (use_ssl: uri.scheme == 'https').merge(configuration.net_http_options)) do |http|
          method_class = case request.method
          when :post then Net::HTTP::Post
          when :get  then Net::HTTP::Get
          when :delete  then Net::HTTP::Delete
          when :put  then Net::HTTP::PUT
          else raise ArgumentError.new("Invalid method #{request.method} is used")
          end

          request = method_class.new uri

          response = http.request request
        end

      end

    end
  end
end