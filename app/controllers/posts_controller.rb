class PostsController < ApplicationController
  before_action :set_categories
  skip_before_action :set_categories, only: [:create, :update, :destroy]

  def index
    @posts = Post.select_by_category_and_date(params[:query])
  end

  def show
    @post = Post.find_by_id(params[:id])
  end

  def new
    @post = Post.new
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

  def set_categories
    @categories = Category.all
  end
end
