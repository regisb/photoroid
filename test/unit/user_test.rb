require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end

  test "has email" do
    u = users(:got_email)
    assert_not_nil(u.email)
    assert_not_equal("", u.email)
  end
  
  test "user without email is invalid" do
    u = users(:got_no_email)
    assert_equal(false, u.valid?)
  end

  test "user with empty email is invalid" do
    u = users(:got_empty_email)
    assert_equal(false, u.valid?)
  end

  test "user with valid email" do
    u = users(:got_email)
    assert_equal(true, u.valid?)
  end
  
  test "user with invalid email" do
    u = users(:got_invalid_email)
    assert_equal(false, u.valid?, "User is considered valid while his email is #{u.email}")
  end

  test "users with duplicate emails" do
    u = users(:got_email)
    u.save
    v = User.new
    v.email = u.email
    assert(!v.save)
  end
end
