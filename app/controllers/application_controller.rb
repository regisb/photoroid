class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :mailer_set_url_options

  def logout
    @_current_user = session[:user_id] = nil
    redirect_to(:controller => :user)
  end

  protected
  def current_user
    @_current_user ||= session[:user_id] && User.find(session[:user_id])
  end
  
  def mailer_set_url_options
    ActionMailer::Base.default_url_options[:host] = request.host_with_port
  end

end
