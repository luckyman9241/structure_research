require 'test_helper'

class CompanyRevenuesControllerTest < ActionController::TestCase
  setup do
    @company_revenue = company_revenues(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:company_revenues)
  end

  test "should create company_revenue" do
    assert_difference('CompanyRevenue.count') do
      post :create, company_revenue: {  }
    end

    assert_response 201
  end

  test "should show company_revenue" do
    get :show, id: @company_revenue
    assert_response :success
  end

  test "should update company_revenue" do
    put :update, id: @company_revenue, company_revenue: {  }
    assert_response 204
  end

  test "should destroy company_revenue" do
    assert_difference('CompanyRevenue.count', -1) do
      delete :destroy, id: @company_revenue
    end

    assert_response 204
  end
end
