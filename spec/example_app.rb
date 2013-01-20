require 'json'
require 'resty'
require 'resty/formats/all'
require 'resty/actions/all'

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

    def index(params)
      [ Post.find(1), Post.find(2), Post.find(3) ]
    end
  end
end