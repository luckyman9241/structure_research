require 'test_helper'

class RevenuesControllerTest < ActionController::TestCase
  setup do
    @revenue = revenues(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:revenues)
  end

  test "should create revenue" do
    assert_difference('Revenue.count') do
      post :create, revenue: {  }
    end

    assert_response 201
  end

  test "should show revenue" do
    get :show, id: @revenue
    assert_response :success
  end

  test "should update revenue" do
    put :update, id: @revenue, revenue: {  }
    assert_response 204
  end

  test "should destroy revenue" do
    assert_difference('Revenue.count', -1) do
      delete :destroy, id: @revenue
    end

    assert_response 204
  end
end
