require 'test_helper'

class ImageControllerTest < ActionController::TestCase
  test "Calling delete deletes the image" do
    user = User.first
    album = user.albums.first
    image = album.images.first

    session["user_id"] = user.id
    delete 'destroy', :id => image.id
    
    assert_nil Image.find_by_id(image.id)
    assert_redirected_to "#{album.secret}"
  end
end
