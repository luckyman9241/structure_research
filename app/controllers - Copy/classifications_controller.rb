class ClassificationsController < ApplicationController
  before_action :set_classification, only: [:show, :edit, :update, :destroy]

  # GET /classifications
  # GET /classifications.json
  def index
    @classifications = Classification.all
  end

  # GET /classifications/1
  # GET /classifications/1.json
  def show
  end

  # GET /classifications/new
  def new
    @classification = Classification.new
  end

  # GET /classifications/1/edit
  def edit
  end

  # POST /classifications
  # POST /classifications.json
  def create
    if params[:id]
      @classification = Classification.find(params[:id])
      @classification.name =params[:name];
      @classification.description= params[:description];
      @classification.status =1;
      @classification.createdOn = Time.now.getutc;
      if @classification.save
        render :json => @classification
      else
        render :json => @classification.errors.full_messages, status: :unprocessable_entity
      end
    else
      @classification = Classification.new
      @classification.name =params[:classification_name];
      @classification.description= params[:classification_description];
      @classification.status =1;
      @classification.createdOn = Time.now.getutc;
      if @classification.save
        render :json => @classification
      else
        render :json => @classification.errors.full_messages, status: :unprocessable_entity
      end
    end
  end

  # PATCH/PUT /classifications/1
  # PATCH/PUT /classifications/1.json
  def update
    respond_to do |format|
      if @classification.update(classification_params)
        format.html { redirect_to @classification, notice: 'Classification was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @classification.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /classifications/1
  # DELETE /classifications/1.json
  def destroy
    @Classification = Classification.find(params[:id])
    begin
      if(@Classification.destroy)
        render :json =>'Successfully'
      end
    rescue => e
      render :json => "#{e}", :status => :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_classification
      @classification = Classification.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def classification_params
      params.require(:classification).permit(:name, :status, :createdOn)
    end
end
