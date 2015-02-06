class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to @user
    else
      render 'new'
    end
  end

  def update
  end

  def show
    # Exclamation point forces RecordNotFound
    # Which redirects to 404 page
    @user = User.find(params[:username]) 
  end

  def index
  end

  private 
    def user_params
      # This enhances security is it forbids a user to addarbitrary params 
      # That we do not accept in the form.
      # Consider the scenario where we have an admin flag in the user model
      # If we permit it then a malicious user can simply set admin=1 in the http request
      # These are called strong params
      # params is a hash
      # :user is a key in params
      # Its value is also a hash
      params.require(:user).permit(:username, :password, :password_confirmation)
    end
end
