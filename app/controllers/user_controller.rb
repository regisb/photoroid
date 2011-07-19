class UserController < ApplicationController
  def new
    @user = User.new
  end

  def edit
    @user = current_user
  end

  def update
    if current_user.update_attributes(params[:user])
      redirect_to :controller => :albums and return
    else
      @user = current_user
      render "user/edit"
    end
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      # Login
      session[:user_id] = @user.id
      redirect_to :controller => :albums and return
    else
      render :controller => :user, :action => :new
    end
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
