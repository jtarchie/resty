module Resty
  module Actions
    Base = Struct.new(:controller, :request) do
      def self.matches?(request)
        false
      end

      def headers
        {}
      end
    end
  end
end
