class ArticlesController < ApplicationController

  layout 'layouts/social_media_enabled', except: [:feed, :index]

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
    # Signed in users can see all Posts, public users only published Posts
    model_array = (signed_in? && Post.admin_all) || Post.published
    @articles = model_array.page params[:page]
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