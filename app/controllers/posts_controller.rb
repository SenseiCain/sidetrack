class PostsController < ApplicationController
  before_action :set_categories, :set_current_user, :find_post
  skip_before_action :find_post, only: [:index, :new, :create]

  def index
    @posts = Post.select_by_category_and_date(params[:query])
    @vote = Vote.new()
  end

  def show
    @comment = Comment.new()
    @vote = Vote.new()
  end

  def new
    @post = Post.new
  end

  def create
    # @post = Post.new(post_params)
    @post = @current_user.posts.build(post_params)

    if @post.save
      redirect_to post_path(@post)
    else
      if @current_user
        render :new
      else
        session[:return_to] ||= request.referer
        redirect_to login_path
      end
    end
  end

  def edit

    unless @post && @post.user == @current_user
      redirect_to root_path
    end
  end

  def update

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

    if @post && @post.user == @current_user
      @post.destroy
    end

    redirect_to root_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :category_ids => [])
  end

  def find_post
    @post = Post.find_by(id: params[:id])
  end

  # '/posts/:id/comments/new - Comments#new'
  # '/posts/:id/comments/create - Comments#create'

  # def new
  #   @comment = Comment.new()
  #   @post = Post.find_by(id: params[:id])
  #   @comment.post = @post
  # end

end
