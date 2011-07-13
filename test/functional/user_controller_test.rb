require 'test_helper'

class UserControllerTest < ActionController::TestCase
  test "Login/Logout" do
    assert_routing "user/logout", :controller => "user", :action => "logout"
    assert_routing "user/login", :controller => "user", :action => "login"
  end

  test "Signup" do
    user_count = User.count
    post :create, {
      :user => { 
        :email => "bob@life.com",
        :password => "1234",
        :password_confirmation => "1234"
      }
    }
    user = User.find_by_email("bob@life.com")
    assert_equal user_count+1, User.count, 
      "Number of users should have raised by one"

    assert_redirected_to :controller => :album
    assert_equal user.id, session["user_id"]
  end
end
