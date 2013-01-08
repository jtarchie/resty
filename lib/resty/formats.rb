require 'resty/formats/base'
require 'resty/formats/html'
require 'resty/formats/json'

module Resty
  module Formats
    extend Enumerable

    def self.each(&block)
      constants.map{|c| self.const_get(c)}.each(&block)
    end
  end
end