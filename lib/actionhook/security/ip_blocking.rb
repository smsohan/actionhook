require 'resolv'

module ActionHook
  module Security
    module IPBlocking

      # This is a crucial security feature for sending webhooks. By default, sending webhooks to loopback
      # interfaces or to the private IP space is blocked. In production, it __should__ remain blocked.

      # If the destination host is an IP address, it's a security risk anyway since you can't have TLS.

      # If the destination host is a domain name, we'll attempt to resolve each of the IP addresses that
      # resolve the domain name and block the webhook based on the configuration.

      class BlockedRequestError < StandardError
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
        if !configuration.allow_private_ips && (ip.private? || ip.loopback?)
          raise PrivateIPError.new("Host: #{host} IP: #{ip} is private")
        end

        if configuration.blocked_custom_ip_ranges
          found = configuration.blocked_custom_ip_ranges.find{|range| range.include?(ip) }
          if found
            raise BlockedRequestError.new("Host: #{host} IP: #{ip} is part of the blocked range: #{found}")
          end
        end
      end

      def verify_hostname_allowed!(configuration, hostname)
        #TODO: Find out of Resolv looks up all kinds of DNS records and if it can be improved by limiting the DNS record types
        Resolv.each_address(hostname) do |ip|
          begin
            #TODO: Add logging
            verify_ip_allowed!(configuration, IPAddr.new(ip), hostname)
          rescue IPAddr::InvalidAddressError
            #TODO: ADD logging
          end
        end
      end

    end
  end
end