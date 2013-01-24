module Resty
  module Actions
    class Show < Base
      def self.matches?(request)
        request.get? && request.path =~ %r{/#{RESOURCE_ID}}
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
        @resource_id ||= request.path.dup.match(%r{/(#{RESOURCE_ID})/?})[1] rescue nil
      end
    end
  end
end