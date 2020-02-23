class CommentsController < ApplicationController
    before_action :set_categories, :set_current_user

    def create
        if @current_user
            @post = Post.find_by(id: comment_params[:post_id])
            @comment = Comment.new(description: comment_params[:description], user: @current_user, post: @post)
            @comment.save

            redirect_to post_path(@post)
        else
            session[:return_to] ||= request.referer
            redirect_to login_path
        end
    end

    def destroy
        @comment = Comment.find_by(id: params[:id])
        @post = @comment.post

        if @comment && @comment.user = @current_user
            @comment.destroy
        end

        redirect_to post_path(@post)
    end

    private

    def comment_params
        params.require(:comment).permit(:description, :post_id)
    end
end