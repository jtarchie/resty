require 'resty/actions/base'
require 'resty/actions/service_unavailable'

module Resty
  module Actions
    extend Enumerable

    def self.each(&block)
      constants.map{|c| self.const_get(c)}.each(&block)
    end
  end
end