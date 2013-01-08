module Resty
  module Actions
    class Show < Base
      def self.matches?(request)
        request.get?
      end

      def status
        if resource
          200
        else
          404
        end
      end

      def resource
        @resource ||= controller.new.show(params)
      end

      private

      def params
        @params ||= request.params.merge(
          id: request.path.dup.match(%r{/(#{RESOURCE_ID})/?})[1]
        )
      end
    end
  end
end