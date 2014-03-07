class TagsController < ApplicationController

  def index
    @tags = Tag.all
  end

  def show
    @tag = Tag.find_by_name(params[:id])

    respond_to do |format|
      format.html do
        @articles = @tag.published_articles.page(params[:page])
      end

      format.atom do
        @articles = @tag.published_articles.limit(Settings['articles.feed.limit'])
        @title = "#{Settings['articles.feed.title']} - #{@tag.display_name}"
        @updated = @articles.maximum(:updated_at)

        render 'articles/index'
      end
    end
  end
end