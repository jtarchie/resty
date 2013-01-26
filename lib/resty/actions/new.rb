module Resty
  module Actions
    class New < Base
      def self.matches?(request)
        request.get? && request.path =~ %r{/new(\.\w+)?/?$}
      end

      def status
        resource ? 200 : 404
      end

      def resource
        @resources ||= action.new(params).resource
      end

      private

      def params
        @params ||= request.params
      end
    end
  end
end