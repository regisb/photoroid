class Album < ActiveRecord::Base
  belongs_to :user
  has_many :images, :order => :taken_at

  validates_presence_of :title
  before_create :create_secret
  
  # Return a random file name composed of 32 letters and numbers
  def self.create_archive_path
    allowed = [('a'..'z'),('0'..'9')].map{|i| i.to_a}.flatten
    name = File.join(Rails.root, "public/album_archives/")
    name += (0...32).map{ allowed[rand(allowed.length)]  }.join
    name += ".zip"
    return name
  end

  protected
  def create_secret
    allowed = [('a'..'z'),('0'..'9')].map{|i| i.to_a}.flatten
    self.secret = (0...32).map{ allowed[rand(allowed.length)]  }.join
  end
end
