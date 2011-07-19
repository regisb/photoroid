class PasswordRemindersController < ApplicationController
  def show
    @password_reminder = PasswordReminder.find_by_secret(params[:secret])
    @user = @password_reminder.user
    session[:user_id] = @user.id
    render "user/edit"

    # TODO destroy password_reminder at appropriate moment
  end

  def new
    @password_reminder = PasswordReminder.new
  end

  def create
    @user = User.find_by_email(params[:user_email])
    if @user.blank?
      # TODO add error message
      render :action => :new and return
    end
    @password_reminder = PasswordReminder.new(:user_id => @user.id)
    @password_reminder.save
    
    # Send mail
    UserMailer.password_reminder(@user, @password_reminder).deliver

    # Redirect to home
    # TODO add message saying the reminder was sent
    redirect_to :controller => :albums, :action => :index
  end
end
