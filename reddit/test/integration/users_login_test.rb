require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
  end

  test "login with valid information" do
    get new_session_path
    post sessions_path, session: { username: @user.username, password: 'password' }
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", new_session_path, count: 0
    assert_select "a[href=?]", sessions_path
  end

  test "login with invalid information" do
    get new_session_path
    post sessions_path, session: { username: @user.username, password: 'passwordd'}
    assert_template 'sessions/new'
  end
end
