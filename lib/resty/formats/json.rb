module Resty
  module Formats
    class JSON < Base
      def self.matches?(request)
        request.path =~ /\.json/
      end

      def to_s
        resource.to_json
      end
    end
  end
end