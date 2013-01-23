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
        @resource ||= controller.constant.new.destroy(params)
      end

      private

      def params
        @params ||= request.params.merge(
          'id' => resource_id
        )
      end

      def resource_id
        @resource_id ||= request.path.dup.match(%r{/(#{RESOURCE_ID})/?})[1] rescue nil
      end
    end
  end
end