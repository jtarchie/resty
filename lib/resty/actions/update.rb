module Resty
  module Actions
    class Update < Base
      def self.matches?(request)
        request.put?
      end

      def status
        resource ? 201 : 404
      end

      def resource
        @resource ||= controller.constant::Update.new(params).resource
      end

      def headers
        return {} unless resource
        {
          'Location' => "/#{controller_name}/#{resource.id}#{format}"
        }
      end

      private

      def format
        request.path.dup.match(%r{(\.\w+)/?$})[1]
      end

      def params
        @params ||= request.params.merge(
          'id' => resource_id
        )
      end

      def resource_id
        @resource_id ||= request.path.dup.match(%r{/(#{RESOURCE_ID})/?})[1] rescue nil
      end

      def controller_name
        controller.name
      end
    end
  end
end