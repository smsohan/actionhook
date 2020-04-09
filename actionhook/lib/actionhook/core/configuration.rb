module ActionHook
  module Core

    class Configuration

      DEFAULT_OPEN_TIMEOUT_IN_SECONDS = 5
      DEFAULT_READ_TIMEOUT_IN_SECONDS = 15
      attr_accessor :open_timeout, :read_timeout

      def initialize(open_timeout = DEFAULT_OPEN_TIMEOUT_IN_SECONDS, read_timeout = DEFAULT_READ_TIMEOUT_IN_SECONDS)
        @open_timeout = open_timeout
        @read_timeout = read_timeout
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