class CompanyGeosController < ApplicationController
  # GET /company_geos
  # GET /company_geos.json
  def index
    @company_geos = CompanyGeo.all

    render json: @company_geos.to_json(:include =>[:company,:geo]), :status=>:ok
  end

  # GET /company_geos/1
  # GET /company_geos/1.json
  def show
    @company_geo = CompanyGeo.find(params[:id])

    render json: @company_geo
  end

  # POST /company_geos
  # POST /company_geos.json
  def create
    if params[:applyAll]==true
      @CompanyGeo = CompanyGeo.where("company_id =:company ",{:company => params[:selected_company]})
      @CompanyGeo.delete_all
      for current_iteration_number in 2010..2025 do
        params[:companyGeoData].each_with_index do |value, index|
          x = value.split('-')
          @company_geo = CompanyGeo.new
          @company_geo.company_id = params[:selected_company];
          @company_geo.geo_id = x[0]
          @company_geo.value = x[2]
          @company_geo.year = current_iteration_number
          @company_geo.status =1;
          @company_geo.save;
        end
      end
    else
      @company_revenue = CompanyGeo.where("year =:year_keyword AND company_id =:company ",{:year_keyword => "#{params[:selected_year]}",:company => params[:selected_company]})
      if @company_revenue.count != 0
        #render :json => "Value against this year is already present.".to_json ,:status=>:unprocessable_entity
        @company_revenue.delete_all
        params[:companyGeoData].each_with_index do |value, index|
          x = value.split('-')
          @company_geo = CompanyGeo.new
          @company_geo.company_id = params[:selected_company];
          @company_geo.geo_id = x[0]
          @company_geo.value = x[2]
          @company_geo.year = params[:selected_year];
          @company_geo.status =1;
          @company_geo.save;
        end
      else
        params[:companyGeoData].each_with_index do |value, index|
          x = value.split('-')
          @company_geo = CompanyGeo.new
          @company_geo.company_id = params[:selected_company];
          @company_geo.geo_id = x[0]
          @company_geo.value = x[2]
          @company_geo.year = params[:selected_year];
          @company_geo.status =1;
          @company_geo.save;
        end
      end
    end
  end


  # PATCH/PUT /company_geos/1
  # PATCH/PUT /company_geos/1.json
  def update
    @company_geo = CompanyGeo.find(params[:id])

    if @company_geo.update(params[:company_geo])
      head :no_content
    else
      render json: @company_geo.errors, status: :unprocessable_entity
    end
  end

  # DELETE /company_geos/1
  # DELETE /company_geos/1.json
  def destroy
    @company_geo = CompanyGeo.find(params[:id])
    @company_geo.destroy

    head :no_content
  end

  # DELETE /company_geos/1
  def getbyName
    
    begin
      if params[:name]=='All'
        @CompanyGeo = CompanyGeo.all
        render :json => @CompanyGeo.to_json(:include =>[:company,:geo]), :status=>:ok
      else
        @like_keyword = "%#{params[:name]}%"    
        #@company = Company.exists?(['name LIKE ?', @like_keyword])
        #@company = CompanyGeo.where("name LIKE :keyword",{:keyword => "#{params[:name]}%"})
        @CompanyGeo = CompanyGeo.joins(:company).where('company.name LIKE :keyword' => {:keyword => "#{params[:name]}%"})
        render :json => @CompanyGeo.to_json(:include =>[:company,:geo]), :status=>:ok
        
      end

    rescue
      render :json=>"No company found"
    end
  end

  def getcompanygeos
    @company = CompanyGeo.where("year = :year AND company_id = :compId",{:year => "#{params[:year]}",:compId => "#{params[:compId]}"})  
    render :json => @company
  end

end
