class Front::PostsController < ApplicationController

  before_action :find_post, only: [:show]

  def show

  end

  def index

  end

  private

  def find_post
    # @post = Page.find(params[:id])
  end
end
