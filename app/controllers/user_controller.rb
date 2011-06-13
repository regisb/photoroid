class UserController < ApplicationController
  def index
    @user = current_user
  end


  def signup
  if request.post?
    # Create new user
    @user = User.new(:email => params[:email])
    # Check confirmed password same as password
    if params[:password] != params[:password_confirm]
      @user.errors.add(:password, "Both password fields must be identical")
      return
    end
    @user.password = params[:password]
    if @user.save
      redirect_to(:controller => :user)
    else
      # Display errors
      return
    end
  else
    # render user creation form
    @user = User.new
  end
  end

  def login
    if request.post?
      # Authenticate user
      if !params[:user]
        redirect_to(:controller => :user)
        return
      end
      @user = User.authenticate(params[:user][:email], params[:user][:password])
      if @user
        session[:user_id] = @user.id
        redirect_to(:controller => :user, :view => :index)
      else
        flash[:notice] = "Invalid email/password combination"
      end
    else
      # Display the login form
      @user = User.new
    end
  end

  def logout
    @_current_user = session[:user_id] = nil
    redirect_to(:controller => :user)
  end

  private
  def current_user
    @_current_user ||= session[:user_id] && User.find(session[:user_id])
  end

end
