class PostsController < ApplicationController
  def index
    @posts = Post.page params[:page]
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end
end