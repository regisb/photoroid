class Image < ActiveRecord::Base
  belongs_to :album
  validates_presence_of :author_name
  has_attached_file :img, :styles => {:medium => "1024x1024>", :thumb => "245x245>"}

  validates_attachment_presence :img
  after_save :add_exif_tags

  def add_exif_tags
    return unless self.taken_at.nil?
    begin
      exif = EXIFR::JPEG.new(self.img.path)
      # Date
      if exif && exif.date_time
        update_attribute(:taken_at, exif.date_time)
      else
        update_attribute(:taken_at, Time.now)
      end
      # Orientation
      if exif && exif.orientation
        case exif.orientation.to_i()
        when 6; update_attribute(:orientation, 90)
          # TODO complete that with other values
        else
          0
        end
      end
    rescue
      update_attribute(:taken_at, Time.now)
    end
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
