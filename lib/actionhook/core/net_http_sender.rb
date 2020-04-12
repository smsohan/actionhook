require 'net/http'
require 'actionhook/security/ip_blocking'


module ActionHook

  module Core


    class NetHTTPSender
      extend ActionHook::Security::IPBlocking

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
        ActionHook.logger.info "[ActionHook] Send called for #{request.method.upcase} to #{request.uri}"

        ActionHook.logger.debug "[ActonHook] Using configuration: #{configuration.inspect}"
        ActionHook.logger.debug "[ActonHook] using net/http options #{configuration.net_http_options}"

        verify_allowed!(configuration, request.uri.host)
        ActionHook.logger.debug "[ActonHook] #{request.uri.host} is clear, not blocked"

        options = { use_ssl: request.uri.scheme == 'https' }.merge(configuration.net_http_options)
        Net::HTTP.start(request.uri.host, request.uri.port, options) do |http|
          http_request = request_method_class(request.method).new request.uri
          http_request.body = request.serialized_body if request.body

          ActionHook.logger.debug "[ActonHook] Body: #{http_request.body}"

          request.headers_with_security(configuration)&.each_pair do |name, value|
            ActionHook.logger.debug "[ActonHook] Added Security Header: #{name}"
            http_request[name] = value.to_s
          end

          http.request http_request
        end

      end

    end

  end

end
