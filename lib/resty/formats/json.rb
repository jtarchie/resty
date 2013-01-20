module Resty
  module Formats
    class JSON < Base
      def self.matches?(request)
        request.path =~ /\.json/
      end

      def body
        resource.to_json
      end

      def headers
        {"Content-type" => "application/json"}
      end
    end
  end
end