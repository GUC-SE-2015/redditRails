class SessionsController < ApplicationController
  
  def new
    @errors = []
  end
  
  def create
    begin
      user = User.find(params[:session][:username])
      if user.authenticate(params[:session][:password])
        log_in user
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
    raise ActionController::BadRequest if !logged_in?
    log_out
    redirect_to root_url
  end
end
