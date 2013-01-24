module Resty
  module Actions
    class Edit < Base
      def self.matches?(request)
        request.get? &&
        request.path =~ %r{\/edit(\.\w+)?/?$} &&
        !Resource.find_by_request(request).id.nil?
      end

      def status
        resource ? 200 : 404
      end

      def resource
        @resources ||= controller.constant::Edit.new(params).resource
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