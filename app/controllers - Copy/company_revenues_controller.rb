class CompanyRevenuesController < ApplicationController
  # GET /company_revenues
  # GET /company_revenues.json
  def index
    @company_revenues = CompanyRevenue.all

    render json: @company_revenues
  end

  # GET /company_revenues/1
  # GET /company_revenues/1.json
  def show
    @company_revenue = CompanyRevenue.find(params[:id])

    render json: @company_revenue
  end

  # POST /company_revenues
  # POST /company_revenues.json
  def create
    if params[:applyAll]==true
      @company_revenue = CompanyRevenue.where("company_id =:company ",{:company => params[:selected_company]})
      @company_revenue.delete_all
      for current_iteration_number in 2010..2025 do
        params[:companyRevenueData].each_with_index do |value, index|
          x = value.split('-')
          @company_revenue = CompanyRevenue.new
          @company_revenue.company_id = params[:selected_company];
          @company_revenue.revenue_id = x[0]
          @company_revenue.value = x[2]
          @company_revenue.year = current_iteration_number
          @company_revenue.status =1;
          @company_revenue.save;
        end
      end
    else
      @company_revenue = CompanyRevenue.where("year =:year_keyword AND company_id =:company ",{:year_keyword => "#{params[:selected_year]}",:company => params[:selected_company]})
      if @company_revenue.count != 0
        #render :json => "Value against this year is already present.".to_json ,:status=>:unprocessable_entity
        @company_revenue.delete_all
        params[:companyRevenueData].each_with_index do |value, index|
          x = value.split('-')
          @company_revenue = CompanyRevenue.new
          @company_revenue.company_id = params[:selected_company];
          @company_revenue.revenue_id = x[0]
          @company_revenue.value = x[2]
          @company_revenue.year = params[:selected_year];
          @company_revenue.status =1;
          @company_revenue.save;
        end
      else
        params[:companyRevenueData].each_with_index do |value, index|
          x = value.split('-')
          @company_revenue = CompanyRevenue.new
          @company_revenue.company_id = params[:selected_company];
          @company_revenue.revenue_id = x[0]
          @company_revenue.value = x[2]
          @company_revenue.year = params[:selected_year];
          @company_revenue.status =1;
          @company_revenue.save;
        end
      end
    end
  end

  # PATCH/PUT /company_revenues/1
  # PATCH/PUT /company_revenues/1.json
  def update
    @company_revenue = CompanyRevenue.find(params[:id])

    if @company_revenue.update(params[:company_revenue])
      head :no_content
    else
      render json: @company_revenue.errors, status: :unprocessable_entity
    end
  end

  # DELETE /company_revenues/1
  # DELETE /company_revenues/1.json
  def destroy
    @company_revenue = CompanyRevenue.find(params[:id])
    @company_revenue.destroy

    head :no_content
  end

  def getcompanyrevenue
    @company = CompanyRevenue.where("year = :year AND company_id = :compId",{:year => "#{params[:year]}",:compId => "#{params[:compId]}"})  
    render :json => @company
  end
end
