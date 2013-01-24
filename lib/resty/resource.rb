module Resty
  Resource = Struct.new(:id) do
    def self.find_by_request(request)
      id = request.path.dup.match(%r{/\w+/([\w-]+)/?})[1] rescue nil
      id = nil if ["edit","new"].include?(id)
      new(id)
    end
  end
end