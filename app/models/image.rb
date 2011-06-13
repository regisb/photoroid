class Image < ActiveRecord::Base
  has_attached_file :img, :styles => {:medium => "1024x1024>", :thumb => "100x100>"}
  validates_attachment_presence :img
end
