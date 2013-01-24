module Resty
  module Actions
    class Create < Base
      def self.matches?(request)
        request.post?
      end

      def status
        resource ? 201 : 404
      end

      def headers
        return {} unless resource
        {
          'Location' => "/#{controller_name}/#{resource.id}#{format}"
        }
      end

      def resource
        @resource ||= controller.constant::Create.new(params).resource
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