require 'test_helper'

class UserControllerTest < ActionController::TestCase
  test "Default route" do
    assert_routing "/", {:controller => "user", :action => "index"}
  end

  test "Signup" do
    user_count = User.count
    post :signup, 
    {
        :email => "bob@life.com",
        :password => "1234",
        :password_confirm => "1234"
    }
    user = User.find_by_email("bob@life.com")
    assert_equal user_count+1, User.count, 
      "Number of users should have raised by one"

    assert_response :redirect
    assert_redirected_to "/"
    assert_equal user.id, session["user_id"]
  end
end
