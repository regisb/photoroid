require 'test_helper'

class AlbumControllerTest < ActionController::TestCase
  test "Default route" do
    assert_recognizes({:controller => "album", :action => "index"}, "/")
  end

  test "Display album" do
    album = albums(:valid)
    get :index, {:secret => album.secret}
    assert_response :success
    assert_not_nil assigns(:album)
  end

  test "Display album with invalid secret" do
    get :index
    assert_redirected_to "/"
  end

  test "Upload images" do
    # Load test image
    f = File.open("test/fixtures/1up.jpg")
    album = albums(:valid)
    image_count = album.images.count
    # Post
    post :upload_images, 
      {:album => {:secret => album.secret, :images => [f]}}
    # Veeeeeery ugly
    assert_redirected_to "/album?secret=#{album.secret}" 
    assert_equal image_count+1, album.images.count, "Number of images in album should have increased by 1"
  end
end
