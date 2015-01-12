require 'test_helper'

class BaseValuesControllerTest < ActionController::TestCase
  setup do
    @base_value = base_values(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:base_values)
  end

  test "should create base_value" do
    assert_difference('BaseValue.count') do
      post :create, base_value: { company_id: @base_value.company_id, growth_value: @base_value.growth_value, is_base: @base_value.is_base, revenue_type: @base_value.revenue_type, value: @base_value.value, year: @base_value.year }
    end

    assert_response 201
  end

  test "should show base_value" do
    get :show, id: @base_value
    assert_response :success
  end

  test "should update base_value" do
    put :update, id: @base_value, base_value: { company_id: @base_value.company_id, growth_value: @base_value.growth_value, is_base: @base_value.is_base, revenue_type: @base_value.revenue_type, value: @base_value.value, year: @base_value.year }
    assert_response 204
  end

  test "should destroy base_value" do
    assert_difference('BaseValue.count', -1) do
      delete :destroy, id: @base_value
    end

    assert_response 204
  end
end
