class Admin::PostsController < Admin::BaseController
  
  def index
    @posts = Post.all
  end
  
  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to [:admin, @post]
    else
      render 'new'
    end
  end

  def update
    @post = Post.find(params[:id])
    
    if @post.update_attributes(post_params)
      redirect_to [:admin, @post]
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to [:admin, posts]
  end

  private
    # Never trust params from the interwebs!  Only allow white-listed params
    def post_params
      params.require(:post).permit(:title, :slug, :content, :author_id, :status)
    end
end
