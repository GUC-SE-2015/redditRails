module SessionsHelper
  def log_in(user)
    session[:user_username] = user.username
  end

  def current_user
    # Can you tell why we used find_by instead of find?
    if (username = session[:user_username])
      @current_user ||= User.find_by(username: username)
    elsif (username = cookies.signed[:user_username])
      user = User.find_by(username: username)
      if user && user.token_matches?(cookies[:remember_token])
        log_in user # Set session info
        @current_user = user
      end
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def forget(user)
    user.forget
    cookies.delete(:user_username)
    cookies.delete(:remember_token)
  end

  def log_out
    forget(current_user)
    session.delete(:user_username)
    @current_user = nil
  end

  # Creates cookies for remember_me functionality
  def remember(user)
    user.remember # Stores token in database
    cookies.permanent.signed[:user_username] = user.username
    cookies.permanent[:remember_token] = user.remember_token
  end

end
