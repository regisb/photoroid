class UserController < ApplicationController
  def new
    @user = User.new
    render :controller => :user, :action => :edit
  end

  def create
    if request.post?
      # Create new user
      @user = User.new(params[:user])
      if @user.save
        session[:user_id] = @user.id
        redirect_to :controller => :albums and return
        # TODO
        # Display errors
      end
    end
    render :controller => :user, :action => :edit
  end

  def login
    if request.post?
      # Authenticate user
      if !params[:user].blank?
        @user = User.authenticate(params[:user][:email], params[:user][:password])
        if @user
          session[:user_id] = @user.id
          redirect_to(:controller => :albums) and return
        else
          flash[:notice] = "Invalid email/password combination"
        end
      end
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to :controller => :albums
  end
end
