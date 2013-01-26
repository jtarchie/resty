module Resty
  class App
    attr_reader :namespace

    def initialize(namespace)
      @namespace = namespace
    end

    def call(env)
      request = Request.new(env)

      controller = Controller.find_by_namespace_and_request(namespace, request)
      action = request.invoker.new(controller, request)
      output = request.formatter.new(action.resource)
    rescue NameError
      action = Actions::ServiceUnavailable.new(controller, request)
      output = request.formatter.new(action.resource)
    ensure
      return [
        action.status,
        action.headers.merge(output.headers),
        output.body
      ]
    end
  end

  class Request < Rack::Request
    def invoker
      Actions.detect do |action|
        action.matches?(self)
      end || Actions::ServiceUnavailable
    end

    def formatter
      Formats.detect do |format|
        format.matches?(self)
      end || Formats::UnknownContentType
    end
  end
end