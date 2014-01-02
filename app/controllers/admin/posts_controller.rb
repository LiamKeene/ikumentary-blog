class Admin::PostsController < Admin::BaseController
  
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  
  def index
    @posts = Post.all
  end
  
  def show
  end

  def new
    @post = Post.new
  end

  def edit
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
    
    if @post.update_attributes(post_params)
      redirect_to [:admin, @post]
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy

    redirect_to [:admin, posts]
  end

  private
    # Never trust params from the interwebs!  Only allow white-listed params
    def post_params
      params.require(:post).permit(:title, :slug, :content, :author_id, :published_at)
    end

  protected
    def find_post
      @post = Post.friendly.find(params[:id])
    end
end
