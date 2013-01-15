module Resty
  class App
    attr_reader :namespace

    def initialize(namespace)
      @namespace = namespace
    end

    def call(env)
      request = Request.new(env)

      action = request.invoker.new(Controller.find_by_request(namespace, request), request)
      body = request.formatter.new(action.resource)
      [action.status, action.headers, body.to_s]
    end
  end

  class Request < Rack::Request
    def invoker
      Actions.detect do |action|
        action.matches?(self)
      end
    end

    def formatter
      Formats.detect do |format|
        format.matches?(self)
      end
    end
  end
end