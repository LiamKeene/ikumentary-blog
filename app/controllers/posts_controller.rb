class PostsController < ApplicationController
  def index
    @posts = Post.published.page params[:page]
  end

  def show
    @post = Post.friendly.find(params[:id])
    @comment = Comment.new
  end
end