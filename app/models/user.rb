require 'digest/sha2'

class User < ActiveRecord::Base
  validates_presence_of :email
  validates_uniqueness_of :email
  validates_email_format_of :email

  attr_accessor :password_confirmation
  validates_confirmation_of :password
  validate :password_non_blank

  validate :max_number_of_users

  has_many :albums
  has_many :images, :through => :albums

  def self.authenticate(email, password)
    user = self.find_by_email(email)
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

    def max_number_of_users
      ###########################################
      # Define here the maximum number of users 
      # that you wish to have in your application
      ###########################################
      max_users = 1

      # Validates that a new user can be created
      # Yes, I know, this is ugly. On the roadmap.
      if User.count >= max_users
        errors.add(:id, "Too many users registered already.")
      end
    end
end
