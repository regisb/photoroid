require 'test_helper'

class ImageTest < ActiveSupport::TestCase
  test "Destroy all test images" do
    Image.destroy_all
  end
  
  test "EXIF tags should be written to image" do
    f = File.open("test/fixtures/1up.jpg")
    image = Image.new(:author_name => "Régis")
    image.img = f
    image.save

    assert_not_nil image.taken_at
  end

  test "EXIF orientation tag should be written to image" do
    f = File.open("test/fixtures/vertical.jpg")
    image = Image.new(:author_name => "Régis")
    image.img = f
    image.save
    assert_equal 90, image.orientation
  end
end
