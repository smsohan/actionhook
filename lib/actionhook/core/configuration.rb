module ActionHook
  module Core

    class Configuration

      DEFAULT_OPEN_TIMEOUT_IN_SECONDS = 5
      DEFAULT_READ_TIMEOUT_IN_SECONDS = 15
      DEFAULT_HASH_HEADER_NAME = 'SHA256-FINGERPRINT'
      attr_accessor :open_timeout, :read_timeout, :hash_header_name,
        :allow_private_ips, :ca_file

      attr_writer :blocked_custom_ip_ranges

      def initialize(open_timeout: DEFAULT_OPEN_TIMEOUT_IN_SECONDS,
        read_timeout: DEFAULT_READ_TIMEOUT_IN_SECONDS,
        hash_header_name: DEFAULT_HASH_HEADER_NAME,
        allow_private_ips: false,
        blocked_custom_ip_ranges: [],
        ca_file: nil
      )
        @open_timeout = open_timeout
        @read_timeout = read_timeout
        @hash_header_name = hash_header_name
        @allow_private_ips = allow_private_ips
        @blocked_custom_ip_ranges = blocked_custom_ip_ranges || []
        @ca_file = ca_file
      end

      def net_http_options
        {
          open_timeout: @open_timeout,
          read_timeout: @read_timeout,
          ca_file: @ca_file
        }.compact
      end

      def blocked_custom_ip_ranges
        @memoized_blocked_custom_ip_ranges ||= @blocked_custom_ip_ranges&.map{|ip| IPAddr.new(ip)} || []
      end

      def allow_all?
        allow_private_ips && blocked_custom_ip_ranges.empty?
      end

    end
  end
end
