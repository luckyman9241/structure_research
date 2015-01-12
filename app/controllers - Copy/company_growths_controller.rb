class CompanyGrowthsController < ApplicationController
  before_action :set_company_growth, only: [:show, :edit, :update, :destroy]

  # GET /company_growths
  # GET /company_growths.json
  def index
    @company_growths = CompanyGrowth.all
    render :json => @company_growths.to_json()
  end

  # GET /company_growths/1
  # GET /company_growths/1.json
  def show
  end

  # GET /company_growths/new
  def new
    @company_growth = CompanyGrowth.new
  end

  # GET /company_growths/1/edit
  def filter
    
       
    @company = CompanyGrowth.where("year LIKE :year_keyword ",{:year_keyword => "#{params[:year]}%"})  
    
    render :json => @company.to_json(:include =>[:company,:growth])
  end

  #get compay revenue detail

  def getcompanygrowth
    #@company = CompanyGrowth.where("year LIKE :year AND company_id = :compId",{:year => "#{params[:year]}%",:compId => "#{params[:compId]}"})  
    result = Hash.new
    result[:revenues] = BaseValue.where("year = ? AND company_id = ?",params[:year],params[:compId])  
    result[:baseValue] = BaseValue.where("company_id = ? AND is_base =1 ",params[:compId])  
    
    

    
    
    render :json => result
    #render :json => company
  end


  #POST /company_growths/api
  def api

    year = params[:selected_year].to_i
    company_id = params[:selected_company].to_i
    revenue_value = params[:base_revenue_value].to_i
    percent = params[:growth_value].to_i
    baseValue = params[:base_values]
    revenuesValues = params[:revenues_values]
    growthValue = 0
    #first delete all records against company
    model = BaseValue.where("company_id = ?",company_id)  
    model.delete_all

    #loop on selected growth types
    baseValue.each_with_index do |baseValue, baseIndex|
    baseX = baseValue.split('-')
     
      

      for current_iteration_number in 2010..2020 do
          x = revenuesValues[baseIndex].split('-')
          if baseX[0].to_i==x[0].to_i && current_iteration_number==x[1].to_i
            diff = current_iteration_number - x[1].to_i
            bb = findPer(growthValue,x[2].to_i)
            if current_iteration_number==baseX[1].to_i
              addCompanyGrowth(x[2].to_i,bb,current_iteration_number,company_id,x[0].to_i,1,baseX[3],baseX[2])
            else
              addCompanyGrowth(x[2].to_i,bb,current_iteration_number,company_id,x[0].to_i,0,0,0)
            end
          else
            diff = current_iteration_number - baseX[1].to_i
            if baseX[0].to_i==x[0].to_i && current_iteration_number==baseX[1].to_i
              addCompanyGrowth(baseX[3].to_i,callApi(current_iteration_number,baseX[1].to_i,baseX[2].to_i,baseX[3].to_i,diff),current_iteration_number,company_id,baseX[0].to_i,1,baseX[3],baseX[2])
              growthValue = callApi(current_iteration_number,baseX[1].to_i,baseX[2].to_i,baseX[3].to_i,diff)
            else
              addCompanyGrowth(baseX[3].to_i,callApi(current_iteration_number,baseX[1].to_i,baseX[2].to_i,baseX[3].to_i,diff),current_iteration_number,company_id,baseX[0].to_i,0,0,0)
              growthValue = callApi(current_iteration_number,baseX[1].to_i,baseX[2].to_i,baseX[3].to_i,diff)
            end
          end
        #end 
      end
    end
  end 

  def findPer(value,percent)
    growthValue = value
    val = (growthValue * percent) / 100
    growthValue = ((growthValue + val).to_f).round(2)
    return growthValue.to_f
  end

  def callApi(year1,year2,value,percent,diff)
    growthValue = value
    if diff > 0
      if diff == 0
        #for growth in 1..diff do
          val = (growthValue * percent) / 100
          growthValue = ((growthValue + val).to_f).round(2)
        #end
      else
        for growth in 1..diff do
          val = (growthValue * percent) / 100
          growthValue = ((growthValue + val).to_f).round(2)
        end
      end
      
    else
      for growth in 1..diff.abs do
        val = (growthValue * percent) / 100
        growthValue = ((growthValue - val).to_f).round(2)
      end
    end
    return growthValue.to_f
  end

  def addCompanyGrowth(basePercent,baseGrowth,year,comapny_id,growth_id,is_base,percent,growth)
    if is_base==1
      @baseValue = BaseValue.new
      @baseValue.company_id = comapny_id
      @baseValue.revenue_type  = growth_id
      @baseValue.base_growth_value = basePercent
      @baseValue.base_value = baseGrowth
      @baseValue.growth_value = percent
      @baseValue.value = growth
      @baseValue.year = year
      @baseValue.is_base = is_base
      @baseValue.save  
    else
      @baseValue = BaseValue.new
      @baseValue.company_id = comapny_id
      @baseValue.revenue_type  = growth_id
      @baseValue.base_growth_value = basePercent
      @baseValue.base_value = baseGrowth
      @baseValue.growth_value = 0
      @baseValue.value = 0
      @baseValue.year = year
      @baseValue.is_base = is_base
      @baseValue.save  
    end

    

  end


  # POST /company_growths
  # POST /company_growths.json
  def create
    @growths = CompanyGrowth.where("year =:year_keyword AND company_id =:company ",{:year_keyword => "#{params[:selected_year]}",:company => params[:selected_company]})
    
    if @growths.count != 0
      #render :json => "Value against this year is already present.".to_json ,:status=>:unprocessable_entity
      @growths.delete_all
      params[:companyGrowthData].each_with_index do |value, index|
        x = value.split('-')
        @CompanyGrowth = CompanyGrowth.new
        @CompanyGrowth.company_id = params[:selected_company]
        @CompanyGrowth.growth_id = x[0]
        @CompanyGrowth.value = x[2]
        @CompanyGrowth.year = params[:selected_year]
        @CompanyGrowth.status =1
        @CompanyGrowth.createdOn = Time.now.getutc
        @CompanyGrowth.save
      end
    else
      params[:companyGrowthData].each_with_index do |value, index|
        x = value.split('-')
        @CompanyGrowth = CompanyGrowth.new
        @CompanyGrowth.company_id = params[:selected_company]
        @CompanyGrowth.growth_id = x[0]
        @CompanyGrowth.value = x[2]
        @CompanyGrowth.year = params[:selected_year]
        @CompanyGrowth.status =1
        @CompanyGrowth.createdOn = Time.now.getutc
        @CompanyGrowth.save
      end
    end
   
  end

  # PATCH/PUT /company_growths/1
  # PATCH/PUT /company_growths/1.json
  def update
    respond_to do |format|
      if @company_growth.update(company_growth_params)
        format.html { redirect_to @company_growth, notice: 'Company growth was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @company_growth.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /company_growths/1
  # DELETE /company_growths/1.json
  def destroy
    @company_growth.destroy
    respond_to do |format|
      format.html { redirect_to company_growths_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company_growth
      @company_growth = CompanyGrowth.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def company_growth_params
      params.require(:company_growth).permit(:company_id, :growth_id, :value, :year, :status, :createdOn)
    end
end
