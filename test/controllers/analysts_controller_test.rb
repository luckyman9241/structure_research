require 'test_helper'

class AnalystsControllerTest < ActionController::TestCase
  setup do
    @analyst = analysts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:analysts)
  end

  test "should create analyst" do
    assert_difference('Analyst.count') do
      post :create, analyst: { : @analyst., name: @analyst.name }
    end

    assert_response 201
  end

  test "should show analyst" do
    get :show, id: @analyst
    assert_response :success
  end

  test "should update analyst" do
    put :update, id: @analyst, analyst: { : @analyst., name: @analyst.name }
    assert_response 204
  end

  test "should destroy analyst" do
    assert_difference('Analyst.count', -1) do
      delete :destroy, id: @analyst
    end

    assert_response 204
  end
end
