module Resty
  App = Struct.new(:namespace) do
    def call(env)
      request = Request.new(env)

      action = request.invoker.new(controller(request), request)
      body = request.formatter.new(action.resource)
      [action.status, action.headers, body.to_s]
    end

    private

    def controller(request)
      controller_path = request.path.match(%r{/(#{CONTROLLER_PATH})})[1]
      class_name = "#{namespace}::#{controller_path.camelize}Controller"
      class_name.constantize
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