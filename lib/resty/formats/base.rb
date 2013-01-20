module Resty
  module Formats
    Base = Struct.new(:resource) do
      def self.matches?(request)
        false
      end

      def headers
        {}
      end

      def body
        ""
      end
    end
  end
end