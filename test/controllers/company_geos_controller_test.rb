require 'test_helper'

class CompanyGeosControllerTest < ActionController::TestCase
  setup do
    @company_geo = company_geos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:company_geos)
  end

  test "should create company_geo" do
    assert_difference('CompanyGeo.count') do
      post :create, company_geo: {  }
    end

    assert_response 201
  end

  test "should show company_geo" do
    get :show, id: @company_geo
    assert_response :success
  end

  test "should update company_geo" do
    put :update, id: @company_geo, company_geo: {  }
    assert_response 204
  end

  test "should destroy company_geo" do
    assert_difference('CompanyGeo.count', -1) do
      delete :destroy, id: @company_geo
    end

    assert_response 204
  end
end
