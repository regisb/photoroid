require 'digest/sha2'

class User < ActiveRecord::Base
  validates_presence_of :email
  validates_uniqueness_of :email
  validates :email, :email_format => {:on => :update}

  attr_accessor :password_confirmation
  validates_confirmation_of :password
  validate :password_non_blank

  def self.authenticate(name, password)
    user = self.find_by_name(name)
    if user
      expected_password = self.encrypted_password(password, user.salt)
      if user.hashed_password != expected_password
        user = nil
      end
    end
    return user
  end

  def password
    @password
  end

  def password=(pwd)
    @password = pwd
    return if pwd.blank?
    create_new_salt
    self.hashed_password = User.encrypted_password(self.password, self.salt)
  end

  private
    def password_non_blank
      errors.add(:password, "Missing password") if hashed_password.blank?
    end

    def create_new_salt
      self.salt = self.object_id.to_s + rand.to_s
    end

    def self.encrypted_password(password, salt)
      string_to_hash = password + "4326587UI°FUI.M%P/Y874IO.M%?KLIF876" + salt
      Digest::SHA2.hexdigest(string_to_hash)
    end
end
