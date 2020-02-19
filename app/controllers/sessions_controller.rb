class SessionsController < ApplicationController
    def new
        @user = User.new
    end

    def create
        @user = User.find_by(email: user_params[:email])

        if @user && @user.authenticate(user_params[:password])
            session[:user_id] = @user.id
        
            if session[:return_to]
                redirect_to session.delete(:return_to)
            else
                redirect_to root_path
            end
        else
            redirect_to login_path
        end
        
    end

    def destroy
        session.delete :user_id
        redirect_to root_path
    end


    private

    def user_params
        params.require(:user).permit(:email, :name, :password)
    end
end