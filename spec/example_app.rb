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
    def to_s
      "Post #{id}"
    end
  end
  Post.create(id: 1)
  Post.create(id: 2)
  Post.create(id: 3)

  class PostsController
    def show(params)
      Post.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      nil
    end

    def index(params)
      [ Post.find(1), Post.find(2), Post.find(3) ]
    end
  end
end