module Front
  module Api::V1
    class PostsController < ApiController
      
      include ApiConcern

      def index
        # index_helper('posts', 'post_categories')
        @status = :ok
        begin
          if params[:post_category_id].present?
            @posts = PostCategory.includes(:posts).find(params[:post_category_id]).posts.includes(:translations)
          else
            @posts = Post.includes(:post_category).includes(:translations).all
            # @posts = Post.all
          end
        rescue => e
          @posts = e.message
          @status = 400
        end

        render json: @posts, status: 200
      end

      def show
        # show_helper('post', 'post_categories')
        @status = :ok
        begin
          if params[:post_category_id].present?
            @post = PostCategory.includes(:posts).find(params[:post_category_id]).posts.includes(:translations).find(params[:id])
          else
            @post = Post.includes(:post_category).includes(:translations).find(params[:id])
          end
        rescue => e
          @post = e.message
          @status = 400
        end

        render json: @post, status: @status
      end
    end
  end
end