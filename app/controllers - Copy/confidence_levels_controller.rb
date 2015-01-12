class ConfidenceLevelsController < ApplicationController
  before_action :set_confidence_level, only: [:show, :edit, :update, :destroy]

  # GET /confidence_levels
  # GET /confidence_levels.json
  def index
    @confidence_levels = ConfidenceLevel.all
  end

  # GET /confidence_levels/1
  # GET /confidence_levels/1.json
  def show
  end

  # GET /confidence_levels/new
  def new
    @confidence_level = ConfidenceLevel.new
  end

  # GET /confidence_levels/1/edit
  def edit
  end

  # POST /confidence_levels
  # POST /confidence_levels.json
  def create
    if params[:id]
      @confidence_level = ConfidenceLevel.find(params[:id])
      @confidence_level.name =params[:name];
      @confidence_level.status =1;
      @confidence_level.createdOn = Time.now.getutc;
      if @confidence_level.save
        render :json => @confidence_level
      else
        render :json => @confidence_level.errors.full_messages, status: :unprocessable_entity
      end
    else
      @confidence_level = ConfidenceLevel.new
      @confidence_level.name =params[:confidence_level_name];
      @confidence_level.status =1;
      @confidence_level.createdOn = Time.now.getutc;
      if @confidence_level.save
        render :json => @confidence_level
      else
        render :json => @confidence_level.errors.full_messages, status: :unprocessable_entity
      end
    end

  end

  # PATCH/PUT /confidence_levels/1
  # PATCH/PUT /confidence_levels/1.json
  def update
    respond_to do |format|
      if @confidence_level.update(confidence_level_params)
        format.html { redirect_to @confidence_level, notice: 'Confidence level was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @confidence_level.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /confidence_levels/1
  # DELETE /confidence_levels/1.json
  def destroy
    @ConfidenceLevel = ConfidenceLevel.find(params[:id])
    begin
      if(@ConfidenceLevel.destroy)
        render :json =>'Successfully'
      end
    rescue => e
      render :json => "#{e}", :status => :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_confidence_level
      @confidence_level = ConfidenceLevel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def confidence_level_params
      params.require(:confidence_level).permit(:name, :status, :createdOn)
    end
end
