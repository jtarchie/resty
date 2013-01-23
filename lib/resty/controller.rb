require "active_support/inflector"

module Resty
  Controller = Struct.new(:namespace, :controller_path) do
    def self.find_by_request(namespace, request)
      controller_path = request.path.match(%r{/(#{CONTROLLER_PATH})})[1]
      new(namespace, controller_path)
    end

    def constant
      @class ||= "#{namespace}::#{controller_path.camelize}Controller".constantize
    end

    def name
      controller_path
    end
  end
end