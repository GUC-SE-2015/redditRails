require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    get new_user_path
    assert_no_difference 'User.count' do
      post users_path, user: {
        username: "",
        password: "password",
        password_confirmation: "pass"
      }
    end
  end

  test "valid signup information" do
    get new_user_path
    assert_difference 'User.count', 1 do
      post_via_redirect users_path, user: {
        username: "testuser",
        password: "password",
        password_confirmation: "password"
      }
      assert_template 'users/show'
      # There are much better ways to do this
      # This is just the default
      assert_select 'title', 'testuser'
      assert is_logged_in?
    end
  end
end
