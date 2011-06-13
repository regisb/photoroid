class Album < ActiveRecord::Base
  validates_presence_of :title
  belongs_to :user
  has_many :images

  validates_presence_of :secret
  validates_length_of :secret, :is => 32
  validates_uniqueness_of :secret
  validate :create_secret, :on => :create

  private
  def create_secret
    allowed = [('a'..'z'),('0'..'9')].map{|i| i.to_a}.flatten
    self.secret = (0..50).map{ allowed[rand(allowed.length)]  }.join
  end
end
