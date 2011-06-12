require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "User with valid email and password" do
    u = User.new
    u.email = "dude2@corp.com"
    u.password="1234"
    assert_not_nil(u.salt, "User salt is nil")
    assert(!u.hashed_password.blank?, "User hashed password is blank")
    assert(ValidatesEmailFormatOf::validate_email_format(u.email).nil?, "User email #{u.email} is invalid")
    assert(u.valid?)
  end

  test "User with invalid email" do
    u = users(:got_invalid_email)#User.new
    #u.email = "dude,gmail.com"
    u.password = "1234"
    assert(!u.save, "User with email #{u.email} should not be valid")
  end

  test "User with duplicate email" do
    u1 = users(:got_email)
    u2 = User.new
    u2.email = u1.email
    u2.password = "123456789"
    assert(!u2.valid?, "User with duplicate email should not be valid")
  end

  test "User with valid email and no password" do
    u = User.new
    u.email = "dude@corp.com"
    assert(!u.valid?, "user with empty password should not be valid")
  end
end
