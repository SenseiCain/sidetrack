class ApplicationController < ActionController::Base
    
    def current_user=(user)
        session[:user_id] = user.id
        @current_user = user
    end
    
    def current_user
        @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
    end

    def set_categories
        @categories = Category.all
    end
    
    def set_user
        @current_user = current_user
    end
end
