class Admin::ArticlesController < Admin::BaseController
  
  before_action :find_article, only: [:show, :edit, :update, :destroy]
  before_action :setup_sti_model, only: [:new, :create]
  
  def index
    @articles = Article.all
  end
  
  def show
  end

  def new
  end

  def edit
  end

  def create
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
      params.require(:article).permit(:type, :title, :slug, :content, :author_id, {category_ids: []}, :allow_comments, :published_at)
    end

    # Sets the `type` attribute from form / query string
    def setup_sti_model
      model = nil
      if !params[:article].blank? and !params[:article][:type].blank?
        model = params[:article].delete(:type).constantize.to_s
        @article = Article.new(article_params)
      else
        @article = Article.new
      end
      @article.type = model
    end

  protected
    def find_article
      @article = Article.friendly.find(params[:id])
    end
end
