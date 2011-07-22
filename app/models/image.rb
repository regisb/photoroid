class Image < ActiveRecord::Base
  belongs_to :album
  validates_presence_of :author_name
  has_attached_file :img, :styles => {:medium => "1024x1024>", :thumb => "245x245>"}

  validates_attachment_presence :img
  after_save :add_exif_tags

  def add_exif_tags
    if self.taken_at.nil?
      # Sample date taken EXIF tag from image
      begin
        exif_info = EXIFR::JPEG.new(self.img.path)
        if exif_info.date_time.nil?
          # Assign now's time if not found
          update_attribute(:taken_at, Time.now)
        else
          update_attribute(:taken_at, exif_info.date_time)
        end
      rescue
        # Rescue on crash, for instance whenever the image is not jpg
        update_attribute(:taken_at, Time.now)
      end
    end
    true
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
