class Album < ActiveRecord::Base
  belongs_to :user
  has_many :images, :order => :taken_at

  validates_presence_of :title
  before_create :create_secret
  
  # Return a random file name composed of 32 letters and numbers
  def self.create_archive_path
    "#{Rails.root}/public/album_archives/#{ActiveSupport::SecureRandom.hex}"
  end
  
  protected
  def create_secret
    self.secret = ActiveSupport::SecureRandom.hex
  end
end
