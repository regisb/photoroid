require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end

  test "User with valid email and password" do
    u = User.new
    u.email = "dude2@corp.com"
    u.password="1234"
    assert_not_nil(u.salt, "User salt is nil")
    assert(!u.hashed_password.blank?, "User hashed password is blank")
    assert(ValidatesEmailFormatOf::validate_email_format(u.email).nil?, "User email #{u.email} is invalid")
    assert(u.valid?)
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
