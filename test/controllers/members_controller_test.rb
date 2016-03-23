require 'test_helper'

class MembersControllerTest < ActionController::TestCase
  test "should get show" do
    get :show
    assert_response :success
  end

  test "should get claim" do
    get :claim
    assert_response :success
  end

  test "should get settings" do
    get :settings
    assert_response :success
  end

end
