module Front
  module Api::V1
    class PostsController < ApiController
      
      include ApiConcern

      def index
        # index_helper('posts', 'post_categories')
        begin
          if params[:post_category_id]
            @posts = PostCategory.includes(:posts).includes(:translations).find(params[:post_category_id]).posts.all
          else
            @posts = Post.includes(:post_category).includes(:translations).all
          end
        rescue=>e
          @posts = e.message
        end

        respond_to do |format|
          format.json {
            begin
              render json: @posts, status: :ok
            rescue
              render json: @posts, status: 400
            end
          }
        end
      end

      def show
        show_helper('post', 'post_categories')
      end
    end
  end
end