require 'json'
require 'resty'
require 'resty/formats/all'
require 'resty/actions/all'
require 'active_record'

module ExampleApp
  ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => ":memory:")
  ActiveRecord::Base.connection.create_table(:posts) do |t|
    t.string :title
    t.text :body
  end

  class Post < ActiveRecord::Base
    attr_accessible :id, :title, :body
    def to_s
      "Post #{id || "not persisted"}"
    end
  end

  class PostsController
    def show(params)
      Post.find(params['id'])
    rescue ActiveRecord::RecordNotFound
      nil
    end

    def index(params)
      Post.all
    end

    def new(params)
      Post.new
    end

    def edit(params)
      Post.find(params['id'])
    end

    def create(params)
      Post.create!(params['post'])
    end

    def update(params)
      post = Post.find(params['id'])
      post.attributes = params['post']
      post.save
      post
    end

    def destroy(params)
      Post.find(params['id']).destroy
    end
  end
end