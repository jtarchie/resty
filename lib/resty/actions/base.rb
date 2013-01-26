module Resty
  module Actions
    Base = Struct.new(:controller, :request) do
      def self.matches?(request)
        false
      end

      def headers
        {}
      end

      private

      def action
        action_class = self.class.name.split('::').last
        controller.constant.const_get(action_class)
      end
    end
  end
end
