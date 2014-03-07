class Admin::CategoriesController < Admin::BaseController

  def index
    @categories = Category.all
  end
  
  def show
    @category = Category.find(params[:id])
  end

  def new
    @category = Category.new
  end

  def edit
    @category = Category.find(params[:id])
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to [:admin, @category]
    else
      render 'new'
    end
  end

  def update
    @category = Category.find(params[:id])
    
    if @category.update_attributes(category_params)
      redirect_to [:admin, @category]
    else
      render 'edit'
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    redirect_to [:admin, :categories]
  end

  private
    # Never trust params from the interwebs!  Only allow white-listed params
    def category_params
      params.require(:category).permit(:name, :display_name)
    end

end