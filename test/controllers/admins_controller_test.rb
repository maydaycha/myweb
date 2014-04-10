require 'test_helper'

class AdminsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get login" do
    get :login
    assert_response :success
  end

  test "should get authenticaiotn" do
    get :authenticaiotn
    assert_response :success
  end

end
