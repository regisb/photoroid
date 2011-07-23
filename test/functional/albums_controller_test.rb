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
    assert_routing "albums/download/#{album.secret}", {:controller => "albums", :action => "download", :secret => album.secret}
  end

  test "Upload image to album routing" do
    assert_routing({:path => "albums/upload_images", :method => :put}, {:controller => "albums", :action => "upload_images"})
  end

  test "Display album" do
    album = albums(:valid)
    get :show, {:secret => album.secret}
    assert_response :success
    assert_not_nil assigns(:album)
  end

  test "Display album with invalid secret" do
    get :show, :secret => "abcdefghijklmnopqrstuvwxyz123456"
    assert_nil assigns(:album)
    assert_template "albums/_invalid"
  end

  test "Upload images" do
    # Load test image
    f = File.open("test/fixtures/1up.jpg")
    album = albums(:valid)
    image_count = album.images.count
    # Post
    put :upload_images, 
      {
        :album => {:secret => album.secret, :images => [f]},
        :author_name => "Régis B."
      }
    assert_redirected_to :controller => "albums", :action => "show", :secret => album.secret
    assert_equal image_count+1, album.images.count, "Number of images in album should have increased by 1"
  end

  test "Destroy album" do
    a = albums(:valid)
    # Album is not destroyed while user is not loged in
    delete 'destroy', :id => a.id
    assert_not_nil Album.find_by_secret(a.secret)
    # Album is destroyed as soon as logged in
    session["user_id"] = a.user_id
    delete 'destroy', :id => a.id
    assert_nil Album.find_by_secret(a.secret)
  end

end
