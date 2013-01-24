module Resty
  module Formats
    class UnknownContentType < Base
      def self.matches?(request)
        false
      end

      def body
        ''
      end

      def headers
        {}
      end
    end
  end
end