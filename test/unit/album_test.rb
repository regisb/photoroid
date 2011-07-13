require 'test_helper'

class AlbumTest < ActiveSupport::TestCase
  test "Create album" do
    user = users(:got_email)
    album = user.albums.build
    album.title = "The Magic Album"
    assert(album.save, "Cannot save album: #{album.errors.to_s}")

    album2 = Album.find(album.id)
    assert_not_nil(album2.secret, "Nil album secret")
    assert_equal(32, album2.secret.length, "Invalid secret length")
  end
end
