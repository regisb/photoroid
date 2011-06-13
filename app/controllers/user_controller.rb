class UserController < ApplicationController
  def index
  end

  def login
    if request.post?
      # Authenticate user
      @user = User.authenticate(params[:user][:email], params[:user][:password])
      if @user
        session[:user_id] = @user.id
      else
        flash[:notice] = "Invalid email/password combination"
      end
      redirect_to :controller => :user, :view => :index
    else
      # Display the login form
      @user = User.new
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to :controller => :tweet
  end

end
