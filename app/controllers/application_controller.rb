class ApplicationController < ActionController::Base
  protect_from_forgery

  def logout
    @_current_user = session[:user_id] = nil
    redirect_to(:controller => :user)
  end

  protected
  def current_user
    @_current_user ||= session[:user_id] && User.find(session[:user_id])
  end

end
