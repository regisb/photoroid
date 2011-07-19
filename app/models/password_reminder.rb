class PasswordReminder < ActiveRecord::Base
  belongs_to :user
  before_create :create_secret

  protected
  def create_secret
    allowed = [('a'..'z'),('0'..'9')].map{|i| i.to_a}.flatten
    self.secret = (0...32).map{ allowed[rand(allowed.length)]  }.join
  end

end
