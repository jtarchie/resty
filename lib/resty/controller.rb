require "active_support/inflector"

module Resty
  module NullController
    NullAction = Struct.new(:params) do
      def method_missing(*args); nil; end
    end
    Index   = NullAction
    Show    = NullAction
    Create  = NullAction
    Update  = NullAction
    Edit    = NullAction
  end

  Controller = Struct.new(:namespace, :controller_path) do
    def self.find_by_namespace_and_request(namespace, request)
      controller_path = request.path.match(%r{^/(\w+)})[1]
      new(namespace, controller_path)
    end

    def self.exists_on_request?(request)
      request.path.match(%r{^/(\w+)(\.\w+)?/?$})[1] rescue nil
    end

    def constant
      @class ||= begin
        "#{namespace}::#{controller_path.camelize}Controller".constantize
      rescue NameError => e
        NullController
      end
    end

    def name
      controller_path
    end
  end
end