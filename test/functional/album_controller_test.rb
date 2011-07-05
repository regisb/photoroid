require 'test_helper'

class AlbumControllerTest < ActionController::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end

  test "Display album" do
    album = albums(:valid)
    get :index, {:secret => album.secret}
    assert_response :success
    assert_not_nil assigns(:album)
  end

  test "Display album with invalid secret" do
    album = albums(:valid)
    get :index
    assert_redirected_to "/user"
    assert_response :redirect
  end

  test "Upload images" do
    # Load test image
    f = File.open("test/fixtures/1up.jpg")
    album = albums(:album_1)
    user = album.user
    # Post
    post :upload_images, 
      {:album => {:id => album.id}, :images => {:image_1 => f.read}}, 
      {:user_id => user.id}
    # Veeeeeery ugly
    assert_redirected_to "album/index?secret=#{album.secret}" 
  end
end
