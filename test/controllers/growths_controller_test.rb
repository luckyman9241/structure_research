require 'test_helper'

class GrowthsControllerTest < ActionController::TestCase
  setup do
    @growth = growths(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:growths)
  end

  test "should create growth" do
    assert_difference('Growth.count') do
      post :create, growth: {  }
    end

    assert_response 201
  end

  test "should show growth" do
    get :show, id: @growth
    assert_response :success
  end

  test "should update growth" do
    put :update, id: @growth, growth: {  }
    assert_response 204
  end

  test "should destroy growth" do
    assert_difference('Growth.count', -1) do
      delete :destroy, id: @growth
    end

    assert_response 204
  end
end
