require 'json'

module ExampleApp
  Post = Struct.new(:attributes) do
    def to_s
      "Post #{attributes[:id]}"
    end

    def to_json
      attributes.to_json
    end

    def self.find(id)
      Post.new(id: id) if id.to_i < 100
    end
  end

  class PostsController
    def show(params)
      Post.find(params[:id])
    end
  end
end