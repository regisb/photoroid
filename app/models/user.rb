class User < ActiveRecord::Base
  validates_presence_of :email
  validates_uniqueness_of :email
  validates_email_format_of :email, :on => :update
end
