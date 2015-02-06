module SessionsHelper
  def log_in(user)
    session[:user_username] = user.username
  end

  def current_user
    # Can you tell why we used find_by instead of find?
    @current_user ||= User.find_by(username: session[:user_username])
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete(:user_username)
    @current_user = nil
  end
end
