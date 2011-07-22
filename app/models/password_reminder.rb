class PasswordReminder < ActiveRecord::Base
  belongs_to :user
  before_create :create_secret
  
  protected
  
  def create_secret
    self.secret = ActiveSupport::SecureRandom.hex
  end
  
end
