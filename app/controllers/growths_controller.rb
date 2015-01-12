class GrowthsController < ApplicationController
  before_action :set_company, only: [:show, :edit, :update, :destroy]

  # GET /growths
  # GET /growths.json
  def index
    @growths = Growth.find(:all, :order => "id ASC")
    #@companies = Company.find(:all, :order => "Name ASC")
    #@company_growths = CompanyGrowth.all
    #@company_geos = CompanyGeo.all
    @geos = Geo.find(:all, :order => "id ASC")
    @revenues = Revenue.find(:all, :order => "id ASC")
    #@company_revenues = CompanyRevenue.all
    @countries = Country.all
    @regions = Region.all



      @result = Hash.new
      @result[:growth] = @growths
      #@result[:companies] =@companies.to_json(:include =>[:confidenceLevel,:nda,:country,:region,:state,:city,:company_type,:companyInvestors,:classifications])
      #@result[:company_growths] = @company_growths.to_json(:include =>[:company,:growth])
      #@result[:company_geos] = @company_geos.to_json(:include =>[:company,:geo])
      @result[:geos]=@geos
      @result[:revenues]=@revenues
      #@result[:company_revenues] =@company_revenues.to_json(:include =>[:company,:revenue])
      @result[:countries]=@countries
      @result[:regions]=@regions

      render :json => @result.to_json, :status=>:ok
    
  end

  
  def show
  end
  
  

  # GET /growths/new
  def new
    @growth = Growth.new
  end

  # GET /growths/1/edit
  def edit
  end

  # POST /growths
  # POST /growths.json
  def create
    if params[:id]
      @growth = Growth.find(params[:id])
      @growth.name=params[:name]
      @growth.status=1
      if @growth.save
        render :json => @growth
      else
        render :json => @growth.errors.full_messages, status: :unprocessable_entity
      end
    else
      @growth = Growth.new
      @growth.name=params[:growth_name]
      @growth.status=1
      if @growth.save
        render :json => @growth
      else
        render :json => @growth.errors.full_messages, status: :unprocessable_entity
      end
    end
    
  end

  # PATCH/PUT /growths/1
  # PATCH/PUT /growths/1.json
  def update
    respond_to do |format|
      if @growth.update(growth_params)
        format.html { redirect_to @growth, notice: 'Growth was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @growth.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /growths/1
  # DELETE /growths/1.json
  def destroy
    @Growth = Growth.find(params[:id])
    begin
      if(@Growth.destroy)
        render :json =>'Successfully'
      end
    rescue => e
      render :json => "#{e}", :status => :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_growth
      @growth = Growth.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def growth_params
      params.require(:growth).permit(:name, :status, :createdOn)
    end
end
