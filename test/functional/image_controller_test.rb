require 'test_helper'

class ImageControllerTest < ActionController::TestCase
  test "Calling delete deletes the image" do
    album = Album.first
    image = album.images.first
    post :delete, :image_id => image.id, :album_secret => album.secret
    assert_nil Image.find_by_id(image.id)
    assert_redirected_to "/album/?secret=#{album.secret}"
  end
end
