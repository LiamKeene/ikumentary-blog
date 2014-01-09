class Admin::PagesController < Admin::BaseController
  
  before_action :find_page, only: [:show, :edit, :update, :destroy]
  
  def index
    @pages = Page.all
  end
  
  def show
  end

  def new
    @page = Page.new
  end

  def edit
  end

  def create
    @page = Page.new(page_params)

    if @page.save
      redirect_to [:admin, @page]
    else
      render 'new'
    end
  end

  def update
    
    if @page.update_attributes(page_params)
      redirect_to [:admin, @page]
    else
      render 'edit'
    end
  end

  def destroy
    @page.destroy

    redirect_to [:admin, pages]
  end

  private
    # Never trust params from the interwebs!  Only allow white-listed params
    def page_params
      params.require(:page).permit(:title, :slug, :content, :author_id, :published_at)
    end

  protected
    def find_page
      @page = Page.friendly.find(params[:id])
    end
end
