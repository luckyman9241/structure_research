class CompanyInvestorsController < ApplicationController
  before_action :set_company_investor, only: [:show, :edit, :update, :destroy]

  # GET /company_investors
  # GET /company_investors.json
  def index
    @company_investors = CompanyInvestor.all
  end

  # GET /company_investors/1
  # GET /company_investors/1.json
  def show
  end

  # GET /company_investors/new
  def new
    @company_investor = CompanyInvestor.new
  end

  # GET /company_investors/1/edit
  def edit
  end

  # POST /company_investors
  # POST /company_investors.json
  def create
    @company_investor = CompanyInvestor.new(company_investor_params)

  end

  # PATCH/PUT /company_investors/1
  # PATCH/PUT /company_investors/1.json
  def update
    respond_to do |format|
      if @company_investor.update(company_investor_params)
        format.html { redirect_to @company_investor, notice: 'Company investor was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @company_investor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /company_investors/1
  # DELETE /company_investors/1.json
  def destroy
    @company_investor.destroy
    respond_to do |format|
      format.html { redirect_to company_investors_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company_investor
      @company_investor = CompanyInvestor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def company_investor_params
      params.require(:company_investor).permit(:company_id, :investor_id, :status, :createdOn)
    end
end
