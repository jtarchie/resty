module Resty
  module Actions
    class Destroy < Base
      def self.matches?(request)
        request.delete?
      end

      def status
        200
      end

      def resource
        @resource ||= action.new(params).resource
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