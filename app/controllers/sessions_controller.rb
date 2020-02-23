class SessionsController < ApplicationController
    skip_before_action :verify_authenticity_token, only: :create

    def new
        @user = User.new
    end

    def create
        if auth_hash
            # byebug
        else

            @user = User.find_by(email: user_params[:email])

            if @user && @user.authenticate(user_params[:password])
                login
            
                if session[:return_to]
                    redirect_to session.delete(:return_to)
                else
                    redirect_to root_path
                end
            else
                redirect_to login_path
            end
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

    def auth_hash
        request.env['omniauth.auth']
    end
end