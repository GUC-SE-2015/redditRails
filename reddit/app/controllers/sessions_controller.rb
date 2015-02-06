class SessionsController < ApplicationController
  
  def new
    @errors = []
  end
  
  def create
    begin
      session = params[:session]
      user = User.find_by(username: session[:username])
      if user.authenticate(session[:password])
        log_in user
        session[:remember_me] == '1' ? remember(user): forget(user)
        redirect_to user
      else
        @errors = ['Invalid username or password']
        raise ActiveRecord::RecordNotFound
      end
    rescue ActiveRecord::RecordNotFound
      render 'new'
    end
  end
  
  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
