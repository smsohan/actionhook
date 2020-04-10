require 'base64'

module ActionHook
  module Security
    module Authentication

      class Base

        def to_h
          { "Authorization" => header_value }
        end

      end

      class Token < Base
        attr_accessor :token
        def initialize(token)
          @token = token
        end

        def header_value
          "Token #{token}"
        end
      end

      class BearerToken < Token
        def header_value
          "Bearer #{token}"
        end
      end

      class Basic < Base
        attr_accessor :username, :password

        def initialize(username:, password:)
          @username = username
          @password = password
        end

        def header_value
          encoded = Base64.strict_encode64("#{username}:#{password}")
          "Basic #{encoded}"
        end

      end

    end
  end
end