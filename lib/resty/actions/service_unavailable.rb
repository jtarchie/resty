module Resty
  module Actions
    class ServiceUnavailable < Base
      def self.matches?(request)
        false
      end

      def status
        501
      end

      def resource
        nil
      end
    end
  end
end