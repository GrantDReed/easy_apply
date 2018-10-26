require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:grant)
    log_in_as(@user)
  end

  test "should get new" do
    get signup_path
    assert_response :success
  end

  test "should get edit" do
    get edit_user_path(@user)
    assert_response :success
  end

  test "should get show" do
    get user_path(@user)
    assert_response :success
  end

end
