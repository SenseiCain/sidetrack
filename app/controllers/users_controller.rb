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
        @user = User.new(user_params)
        if @user.save
            login
            redirect_to root_path
        else
            render :new, layout: 'sessions'
        end
    end

    private

    def user_params
        params.require(:user).permit(:name, :email, :email_confirmation, :password, :password_confirmation)
    end

    def url_decode(name)

        if name.match(/-/)
            name.gsub('-', ' ')
        end

        name.downcase
    end
end