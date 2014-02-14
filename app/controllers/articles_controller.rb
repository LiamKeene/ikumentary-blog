class ArticlesController < ApplicationController

  # Feed contains only Posts
  def feed
    @articles = Post.published.limit(15)
    @title = 'Ikumentary Blog'
    @updated = @articles.maximum(:updated_at)

    respond_to do |format|
      format.atom { render 'index' }
    end
  end    

  # Index page contains only Posts
  def index
    @articles = Post.published.page params[:page]
  end

  # Show page contains a single Post
  def show
    @article = Post.friendly.find(params[:id])
    @comment = Comment.new
  end

  # Show_page contains a single Page
  def show_page
    @article = Page.friendly.find(params[:id])
    @comment = Comment.new
    render 'articles/show'
  end
end