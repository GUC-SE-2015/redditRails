require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
  end

  test "login with valid information" do
    get new_session_path
    post session_path, session: { username: @user.username, password: 'password' }
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", new_session_path, count: 0
    assert_select "a[href=?]", session_path
  end

  test "login with invalid information" do
    get new_session_path
    post session_path, session: { username: @user.username, password: 'passwordd'}
    assert_template 'sessions/new'
  end

  test "login and logout" do
    get new_session_path
    post session_path, session: {username: @user.username, password: 'password'}
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    # should be at profile
    assert_template 'users/show'
    # Logout
    delete session_path
    assert_redirected_to root_url

  end
end
