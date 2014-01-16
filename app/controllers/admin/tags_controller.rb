class Admin::TagsController < ApplicationController

  def index
    @tags = Tag.all
  end
  
  def show
    @tag = Tag.find(params[:id])
  end

  def new
    @tag = Tag.new
  end

  def edit
    @tag = Tag.find(params[:id])
  end

  def create
    @tag = Tag.new(tag_params)

    if @tag.save
      redirect_to [:admin, @tag]
    else
      render 'new'
    end
  end

  def update
    @tag = Tag.find(params[:id])
    
    if @tag.update_attributes(tag_params)
      redirect_to [:admin, @tag]
    else
      render 'edit'
    end
  end

  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy

    redirect_to [:admin, :tags]
  end

  private
    # Never trust params from the interwebs!  Only allow white-listed params
    def tag_params
      params.require(:tag).permit(:name, :display_name)
    end

end
