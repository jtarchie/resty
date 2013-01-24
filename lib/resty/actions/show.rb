module Resty
  module Actions
    class Show < Base
      def self.matches?(request)
        resource = Resource.find_by_request(request)
        request.get? &&
        !resource.id.nil? &&
        request.path =~ %r{#{resource.id}(\.\w+)?/?$}
      end

      def status
        resource ? 200 : 404
      end

      def resource
        @resource ||= controller.constant::Show.new(params).resource
      end

      private

      def params
        @params ||= request.params.merge(
          'id' => resource_id
        )
      end

      def resource_id
        @resource_id ||= Resource.find_by_request(request).id
      end
    end
  end
end