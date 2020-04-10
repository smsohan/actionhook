require 'resolv'

module ActionHook
  module Security
    module IPBlocking

      class BlockedRequestError < StandardError
        attr_accessor :hostname_or_ip, :blocked_reason

        def initialize(hostname_or_ip:, resolved_ip:, blocked_reason:)
          @hostname_or_ip = hostname_or_ip
          @resolved_ip = resolved_ip
          @blocked_reason = blocked_reason
        end
      end

      class PrivateIPError < StandardError
      end

      def verify_allowed!(configuration, hostname_or_ip)
        return if configuration.allow_all?

        begin
          verify_ip_allowed!(configuration, IPAddr.new(hostname_or_ip))
        rescue IPAddr::InvalidAddressError
          verify_hostname_allowed!(configuration, hostname_or_ip)
        end

      end

      protected

      def verify_ip_allowed!(configuration, ip, host = ip)
        if configuration.allow_private_ips && ip.private?
          raise PrivateIPError.new("Host: #{host} IP: #{ip} is private")
        end

        if configuration.blocked_custom_ip_ranges
          found = configuration.blocked_custom_ip_ranges.find{|range| IPAddr.new(range).include?(ip) }
          if found
            raise BlockedRequestError.new("Host: #{host} IP: #{ip} is part of the blocked range: #{found}")
          end
        end
      end

      def verify_hostname_allowed!(configuration, hostname)
        Resolv.each_address(hostname) do |ip|
          verify_ip_allowed!(configuration, IPAddr.new(ip), hostname)
        end
      end

    end
  end
end