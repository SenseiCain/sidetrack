class PostsController < ApplicationController
  def index
    @posts = Post.select_by_category_and_date(params[:query])
    @categories = Category.all
    @dates = ['Past week', 'Past month', 'Past year']
  end

  def show
    @categories = Category.all
    @post = Post.find_by_id(params[:id])
  end

  def new
    @post = Post.new
    @categories = Category.all
  end

  def create
    @post = Post.new(post_params)
    @post.user = User.first

    if @post.save
      redirect_to root_path
    else
      render new_post_path
    end
  end

  def edit
    
  end

  def update
  end

  def destroy
  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :category_ids => [])
  end
end
