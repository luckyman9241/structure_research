require 'test_helper'

class UserTypesControllerTest < ActionController::TestCase
  setup do
    @user_type = user_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_types)
  end

  test "should create user_type" do
    assert_difference('UserType.count') do
      post :create, user_type: {  }
    end

    assert_response 201
  end

  test "should show user_type" do
    get :show, id: @user_type
    assert_response :success
  end

  test "should update user_type" do
    put :update, id: @user_type, user_type: {  }
    assert_response 204
  end

  test "should destroy user_type" do
    assert_difference('UserType.count', -1) do
      delete :destroy, id: @user_type
    end

    assert_response 204
  end
end
