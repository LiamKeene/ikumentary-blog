class ArticlesController < ApplicationController

  # Index page contains only Posts
  def index
    @posts = Post.published.page params[:page]
    render 'posts/index'
  end

  # Show page contains a single Post
  def show
    @post = Post.friendly.find(params[:id])
    @comment = Comment.new
    render 'posts/show'
  end
end