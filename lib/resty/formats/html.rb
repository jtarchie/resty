module Resty
  module Formats
    class HTML < Base
      def self.matches?(request)
        request.path =~ /\.html$/ || request.path !~ /\.\w+$/
      end

      def to_s
        if resource.is_a?(Array)
          resource.map{|r| self.class.new(r).to_s }.join
        else
          "<h1>#{resource.to_s}</h1>"
        end
      end
    end
  end
end