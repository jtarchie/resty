module Resty
  module Formats
    class HTML < Base
      def self.matches?(request)
        request.path =~ /\.html$/ || request.path !~ /\.\w+$/
      end

      def to_s
        "<h1>#{resource.to_s}</h1>"
      end
    end
  end
end