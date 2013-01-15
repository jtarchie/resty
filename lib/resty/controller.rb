module Resty
  class Controller
    def self.find_by_request(namespace, request)
      controller_path = request.path.match(%r{/(#{CONTROLLER_PATH})})[1]
      class_name = "#{namespace}::#{controller_path.camelize}Controller"
      class_name.constantize
    end
  end
end