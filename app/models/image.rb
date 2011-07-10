class Image < ActiveRecord::Base
  has_attached_file :img, :styles => {:medium => "1024x1024>", :thumb => "245x245>"}
  validates_attachment_presence :img
  after_save :add_exif_tags
  belongs_to :album

  def add_exif_tags
    # Sample date taken EXIF tag from image
    exif_info = EXIFR::JPEG.new(self.img.path)
    if exif_info.date_time.nil?
      # Assign now's time if not found
      update_attribute(:taken_at, Time.now)
    else
      update_attribute(:taken_at, exif_info.date_time)
    end
  end
end
