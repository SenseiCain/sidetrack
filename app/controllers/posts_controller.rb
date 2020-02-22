class PostsController < ApplicationController

  before_action :set_categories, :set_current_user
  skip_before_action :set_categories, only: [:destroy]
  skip_before_action :set_current_user, only: [:destroy]

  def index
    @posts = Post.select_by_category_and_date(params[:query])
    @vote = Vote.new()
  end

  def show
    @post = Post.find_by_id(params[:id])
    @comment = Comment.new()
    @vote = Vote.new()
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = @current_user

    if @post.save
      redirect_to post_path(@post)
    else
      if @user
        render new_post_path
      else
        session[:return_to] ||= request.referer
        redirect_to login_path
      end
    end
  end

  def edit
    @post = Post.find_by(id: params[:id])

    if @post && @post.user == @current_user

    else
      redirect_to root_path
    end
  end

  def update
    @post = Post.find_by(id: params[:id])

    if @post && @post.user == @current_user
      if @post.update(post_params)
        redirect_to post_path(@post)
      else
        render :edit
      end
    else
      redirect_to root_path
    end
  end

  def destroy
  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :category_ids => [])
  end

end
