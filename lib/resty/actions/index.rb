module Resty
  module Actions
    class Index < Base
      def self.matches?(request)
        request.get? &&
        request.path !~ %r{/(edit|new)/?$} &&
        request.path !~ %r{/#{RESOURCE_ID}}
      end

      def status
        resource ? 200 : 404
      end

      def resource
        @resources ||= controller.constant.new.index(params)
      end

      private

      def params
        @params ||= request.params
      end
    end
  end
end