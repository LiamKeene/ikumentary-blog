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
        @articles = @category.published_articles.limit(Settings['articles.feed.limit'])
        @title = "#{Settings['articles.feed.title']} - #{@category.display_name}"
        @updated = @articles.maximum(:updated_at)

        render 'articles/index'
      end
    end
  end
end