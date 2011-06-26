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

end
