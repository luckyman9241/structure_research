class CompanyRegionsGrowthsController < ApplicationController
  before_action :set_company_regions_growth, only: [:show, :edit, :update, :destroy]

  # GET /company_regions_growths
  # GET /company_regions_growths.json
  def index
    @company_regions_growths = CompanyRegionsGrowth.all
  end

  # GET /company_regions_growths/1
  # GET /company_regions_growths/1.json
  def show
  end

  # GET /company_regions_growths/new
  def new
    @company_regions_growth = CompanyRegionsGrowth.new
  end

  # GET /company_regions_growths/1/edit
  def edit
  end

  # POST /company_regions_growths
  # POST /company_regions_growths.json
  def create
    @company_regions_growth = CompanyRegionsGrowth.new(company_regions_growth_params)

    respond_to do |format|
      if @company_regions_growth.save
        format.html { redirect_to @company_regions_growth, notice: 'Company regions growth was successfully created.' }
        format.json { render action: 'show', status: :created, location: @company_regions_growth }
      else
        format.html { render action: 'new' }
        format.json { render json: @company_regions_growth.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /company_regions_growths/1
  # PATCH/PUT /company_regions_growths/1.json
  def update
    respond_to do |format|
      if @company_regions_growth.update(company_regions_growth_params)
        format.html { redirect_to @company_regions_growth, notice: 'Company regions growth was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @company_regions_growth.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /company_regions_growths/1
  # DELETE /company_regions_growths/1.json
  def destroy
    @company_regions_growth.destroy
    respond_to do |format|
      format.html { redirect_to company_regions_growths_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company_regions_growth
      @company_regions_growth = CompanyRegionsGrowth.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def company_regions_growth_params
      params.require(:company_regions_growth).permit(:region_id, :company_id, :value, :year, :status, :createdOn)
    end
end
