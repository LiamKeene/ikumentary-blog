class CommentsController < ApplicationController
  
  def index
    @comments = Comment.all
  end
  
  def show
    @comment = Comment.find(params[:id])
  end

  def new
    @comment = Comment.new
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      redirect_to @comment
    else
      render 'new'
    end
  end

  def update
    @comment = Comment.find(params[:id])
    
    if @comment.update_attributes(comment_params)
      redirect_to @comment
    else
      render 'edit'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    redirect_to comments_path
  end

  private
    # Never trust params from the interwebs!  Only allow white-listed params
    def comment_params
      params.require(:comment).permit(:post_id, :author, :email, :content)
    end
end