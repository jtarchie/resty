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
    validates :title, presence: true
    attr_accessible :id, :title, :body
    def to_s
      "Post #{id || "not persisted"}"
    end
  end

  module UsersController
  end

  module PostsController
    Action = Struct.new(:params)

    class Show < Action
      def resource
          Post.find(params['id'])
        rescue ActiveRecord::RecordNotFound
          nil
      end
    end

    class Index < Action
      def resource
        Post.all
      end
    end

    class New < Action
      def resource
        Post.new
      end
    end

    class Edit < Action
      def resource
        Post.find(params['id'])
      end
    end

    class Create < Action
      def resource
        post = Post.create(params['post'])
        post.persisted? ? post : nil
      end
    end

    class Update < Action
      def resource
        post = Post.find(params['id'])
        post.attributes = params['post']
        post.save
        post
      end
    end

    class Destroy < Action
      def resource
        Post.find(params['id']).destroy
      end
    end
  end
end