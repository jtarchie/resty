module Resty
  module Actions
    class Create < Base
      def self.matches?(request)
        request.post?
      end

      def status
        201
      end

      def headers
        {
          'Location' => "/#{controller_name}/#{resource.id}#{format}"
        }
      end

      def resource
        @resource ||= controller.constant.new.create(params)
      end

      private

      def format
        request.path.dup.match(%r{(\.\w+)/?$})[1]
      end

      def params
        @params ||= request.params
      end

      def controller_name
        controller.name
      end
    end
  end
end