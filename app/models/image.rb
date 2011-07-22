class Image < ActiveRecord::Base
  belongs_to :album
  validates_presence_of :author_name
  has_attached_file :img, :styles => {:medium => "1024x1024>", :thumb => "245x245>"}

  validates_attachment_presence :img
  after_save :add_exif_tags

  def add_exif_tags
    self.taken_at ||= EXIFR::JPEG.new(img.path).date_time rescue Time.now
    # FIXME: We could get rid of this second save call if this methods was called on before_save
    self.taken_at.save
  end

  # The default paperclip URL methods precedes everything 
  # with a "/", which does not work whenever we deploy to 
  # a sub URI. Solution consists in stripping the first 
  # character if it's a "/"
  def url(style)
    url = img.url(style)
    return url if url.blank?
    url.starts_with?('/') ? url.gsub(/^\//, '') : url
  end
end
