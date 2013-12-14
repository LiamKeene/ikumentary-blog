class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])

    @comment = Comment.new(params[:comment].permit(:post_id, :author, :email, :content))
    
    @comment.post = @post

    if @comment.save
      redirect_to post_path(@post)
    else
      render template: 'posts/show'
    end

  end  

end