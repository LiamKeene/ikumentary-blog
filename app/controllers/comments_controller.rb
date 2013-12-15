class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])

    @comment = Comment.new(params[:comment].permit(:post_id, :author, :email, :content))
    
    @comment.post = @post

    # Assign the remote IP and user agent
    @comment.ip_addr = request.remote_ip
    @comment.agent = request.user_agent

    if @comment.save
      redirect_to post_path(@post)
    else
      render template: 'posts/show'
    end

  end  

end