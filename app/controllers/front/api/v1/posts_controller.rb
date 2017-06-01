module Front
  module Api::V1
    class PostsController < ApiController
      
      include ApiConcern

      def index
        index_helper('posts', 'post_categories')
      end

      def show
        show_helper('post', 'post_categories')
      end
    end
  end
end