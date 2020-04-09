require 'json'
module ActionHook
  module Core
    class JSONRequest < Request

      def serialized_body
        return @serialized_body if @serialized_body

        if body.is_a?(Hash) || body.is_a?(Array)
          @serialized_body = JSON.generate(body)
        else
          super
        end

      end

    end
  end
end