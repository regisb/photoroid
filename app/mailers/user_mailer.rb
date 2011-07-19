class UserMailer < ActionMailer::Base
  default :from => "noreply@paparazzi.com"

  def password_reminder(user, password_reminder)
    @user = user
    @password_reminder = password_reminder
    mail(
      :to => @user.email, 
      :subject => "[Paparazzi] Password reset instructions"
    )
  end
end
