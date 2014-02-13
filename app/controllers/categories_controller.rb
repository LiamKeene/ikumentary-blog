class CategoriesController < ApplicationController

  def index
    @categories = Category.all
  end

  def show
    @category = Category.find_by_name(params[:id])

    respond_to do |format|
      format.html do
        @articles = @category.published_articles.page(params[:page])
      end

      format.atom do
        @articles = @category.published_articles.limit(15)
        @title = "Ikumentary Blog - #{@category.display_name}"
        @updated = @articles.maximum(:updated_at)

        render 'articles/index'
      end
    end
  end
end