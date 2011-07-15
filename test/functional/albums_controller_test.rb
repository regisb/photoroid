require 'test_helper'

class AlbumsControllerTest < ActionController::TestCase
  test "Default route" do
    assert_recognizes({:controller => "albums", :action => "index"}, "/")
  end

  test "Show album with secret route" do
    album = Album.first
    assert_routing "#{album.secret}", {:controller => "albums", :action => "show", :secret => album.secret}
  end

  test "Download album with secret route" do
    album = Album.first
    assert_routing "album/download/#{album.secret}", {:controller => "albums", :action => "download", :secret => album.secret}
  end

  test "Upload image to album routing" do
    assert_routing({:path => "album/upload_images", :method => :put}, {:controller => "albums", :action => "upload_images"})
  end

  test "Display album" do
    album = albums(:valid)
    get :show, {:secret => album.secret}
    assert_response :success
    assert_not_nil assigns(:album)
  end

  test "Display album with invalid secret" do
    get :show, :secret => "abcdefghijklmnopqrstuvwxyz123456"
    assert_redirected_to "/user"
  end

  test "Upload images" do
    # Load test image
    f = File.open("test/fixtures/1up.jpg")
    album = albums(:valid)
    image_count = album.images.count
    # Post
    post :upload_images, 
      {:album => {:secret => album.secret, :images => [f]}}
    assert_redirected_to :controller => "albums", :action => "show", :secret => album.secret
    assert_equal image_count+1, album.images.count, "Number of images in album should have increased by 1"
  end

  test "Destroy album" do
    a = albums(:valid)
    delete 'destroy', :secret => a.secret
    assert_nil Album.find_by_secret(a.secret)
  end

end
