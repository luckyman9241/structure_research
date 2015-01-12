class CompanyClassificationsController < ApplicationController
  before_action :set_company_classification, only: [:show, :edit, :update, :destroy]

  # GET /company_classifications
  # GET /company_classifications.json
  def index
    @company_classifications = CompanyClassification.all
  end

  # GET /company_classifications/1
  # GET /company_classifications/1.json
  def show
  end

  # GET /company_classifications/new
  def new
    @company_classification = CompanyClassification.new
  end

  # GET /company_classifications/1/edit
  def edit
  end

  # POST /company_classifications
  # POST /company_classifications.json
  def create
    @company_classification = CompanyClassification.new
    @company_classification.company_id = 1 #params[:]
    @company_classification.classification_id = 1 #params[:]
    @company_classification.status = 1
    @company_classification.save
    render :json => @company_classifications.to_json(:include =>[:company,:classification])

  
  end

  # PATCH/PUT /company_classifications/1
  # PATCH/PUT /company_classifications/1.json
  def update
    respond_to do |format|
      if @company_classification.update(company_classification_params)
        format.html { redirect_to @company_classification, notice: 'Company classification was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @company_classification.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /company_classifications/1
  # DELETE /company_classifications/1.json
  def destroy
    @company_classification.destroy
    respond_to do |format|
      format.html { redirect_to company_classifications_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company_classification
      @company_classification = CompanyClassification.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def company_classification_params
      params.require(:company_classification).permit(:company_id, :classification_id, :status, :createdOn)
    end
end
