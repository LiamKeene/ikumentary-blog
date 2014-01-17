class TagsController < ApplicationController

  def index
    @tags = Tag.all
  end

  def show
    @tag = Tag.find_by_name(params[:id])
    @articles = @tag.published_articles.page(params[:page])
  end
end