require 'resty/formats/base'

module Resty
  module Formats
    extend Enumerable

    def self.each(&block)
      constants.map{|c| self.const_get(c)}.each(&block)
    end
  end
end