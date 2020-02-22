class CommentsController < ApplicationController
    before_action :set_categories, :set_current_user

    def create
        if @current_user
            @comment = Comment.new(description: comment_params[:description])
            @comment.user = @current_user
            @post = Post.find_by(id: comment_params[:post_id])
            @comment.post = @post

            if @comment.save
                redirect_to post_path(@post)
            else
                redirect_to post_path(@post)
            end
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
            redirect_to post_path(@post)
        else
            redirect_to root_path
        end
    end

    private

    def comment_params
        params.require(:comment).permit(:description, :post_id)
    end
end