module ActionHook
  module Core

    class Configuration

      DEFAULT_OPEN_TIMEOUT_IN_SECONDS = 5
      DEFAULT_READ_TIMEOUT_IN_SECONDS = 15
      DEFAULT_HASH_HEADER_NAME = 'SHA256-FINGERPRINT'
      attr_accessor :open_timeout, :read_timeout, :hash_header_name

      def initialize(open_timeout: DEFAULT_OPEN_TIMEOUT_IN_SECONDS,
        read_timeout: DEFAULT_READ_TIMEOUT_IN_SECONDS,
        hash_header_name: DEFAULT_HASH_HEADER_NAME
      )
        @open_timeout = open_timeout
        @read_timeout = read_timeout
        @hash_header_name = hash_header_name
      end

      def net_http_options
        {
          open_timeout: @open_timeout,
          read_timeout: @read_timeout
        }
      end

    end
  end
end