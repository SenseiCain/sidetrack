class UsersController < ApplicationController
    before_action :set_categories, :set_current_user

    def show
        if @reference_user = User.find_by(name: url_decode(params[:id]))
            @posts = @reference_user.posts
            @vote = Vote.new()
        else
            redirect_to root_path
        end
    end

    def new
        @user = User.new
        render layout: 'sessions'
    end

    def create

    end

    private

    def url_decode(name)
        name.gsub!('-', ' ').titlecase
    end
end