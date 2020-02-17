class PostsController < ApplicationController
  def index
    @posts = Post.all
    @categories = Category.all
    @dates = ['Past week', 'Past month', 'Past year']
  end

  def show
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
