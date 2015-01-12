require 'test_helper'

class LegendValuesControllerTest < ActionController::TestCase
  setup do
    @legend_value = legend_values(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:legend_values)
  end

  test "should create legend_value" do
    assert_difference('LegendValue.count') do
      post :create, legend_value: {  }
    end

    assert_response 201
  end

  test "should show legend_value" do
    get :show, id: @legend_value
    assert_response :success
  end

  test "should update legend_value" do
    put :update, id: @legend_value, legend_value: {  }
    assert_response 204
  end

  test "should destroy legend_value" do
    assert_difference('LegendValue.count', -1) do
      delete :destroy, id: @legend_value
    end

    assert_response 204
  end
end
