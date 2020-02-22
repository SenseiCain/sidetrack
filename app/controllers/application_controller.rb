class ApplicationController < ActionController::Base
    
    def current_user
        @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
    end

    def set_categories
        @categories = Category.all
    end
    
    def set_current_user
        @current_user = current_user
    end

    def login
        session[:user_id] = @user.id
    end
end
