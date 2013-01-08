module Resty
  module Formats
    Base = Struct.new(:resource) do
      def self.matches?(request)
        false
      end
    end
  end
end