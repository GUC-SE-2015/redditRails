class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  protected
    def log_in_required
      unless logged_in?
        flash[:danger] = "Login Required."
        redirect_to new_session_path
      end
    end
end
