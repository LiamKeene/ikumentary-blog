class CommentsController < ApplicationController

  def create
    @article = Article.friendly.find(params[:article_id])

    @comment = Comment.new(params[:comment].permit(:article_id, :author, :email, :content))
    
    @comment.article = @article

    # Assign the remote IP and user agent
    @comment.ip_addr = request.remote_ip
    @comment.agent = request.user_agent

    if @comment.save
      redirect_to article_path(@article)
    else
      render template: 'articles/show'
    end
  end
end
