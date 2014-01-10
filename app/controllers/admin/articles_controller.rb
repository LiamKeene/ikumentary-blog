class Admin::ArticlesController < Admin::BaseController
  
  before_action :find_article, only: [:show, :edit, :update, :destroy]
  
  def index
    @articles = Article.all
  end
  
  def show
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to [:admin, @article]
    else
      render 'new'
    end
  end

  def update
    
    if @article.update_attributes(article_params)
      redirect_to [:admin, @article]
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy

    redirect_to [:admin, articles]
  end

  private
    # Never trust params from the interwebs!  Only allow white-listed params
    def article_params
      params.require(:article).permit(:title, :slug, :content, :author_id, :published_at)
    end

  protected
    def find_article
      @article = Article.friendly.find(params[:id])
    end
end
