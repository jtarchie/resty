require "resty/version"
require "active_support/inflector"

module Resty
  RESOURCE_ID = %r{\d+}
  CONTROLLER_PATH = %r{\w+}

  autoload :App, "resty/app"
  autoload :Actions, "resty/actions"
  autoload :Formats, "resty/formats"
  autoload :Controller, "resty/controller"
end
