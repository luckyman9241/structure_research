class RegionsController < ApplicationController
  before_action :set_region, only: [:show, :edit, :update, :destroy]

  # GET /regions
  # GET /regions.json
  def index
    @regions = Region.all
  end

  # GET /regions/1
  # GET /regions/1.json
  def show
  end

  # GET /regions/new
  def new
    @region = Region.new
  end

  # GET /regions/1/edit
  def edit
  end

  # POST /regions
  # POST /regions.json
  def create
    if params[:id]
      @region = Region.find(params[:id])
      @region.name =params[:name];
      @region.status =1;
      @region.createdOn = Time.now.getutc;
      if @region.save
        render :json => @region
      else
        render :json => @region.errors.full_messages, status: :unprocessable_entity
      end
    else
      @region = Region.new
      @region.name =params[:region_name];
      @region.status =1;
      @region.createdOn = Time.now.getutc;
      if @region.save
        render :json => @region
      else
        render :json => @region.errors.full_messages, status: :unprocessable_entity
      end
    end 
  end

  # PATCH/PUT /regions/1
  # PATCH/PUT /regions/1.json
  def update
    respond_to do |format|
      if @region.update(region_params)
        format.html { redirect_to @region, notice: 'Region was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @region.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /regions/1
  # DELETE /regions/1.json
  def destroy
    @Region = Region.find(params[:id])
    begin
      if(@Region.destroy)
        render :json =>'Successfully'
      end
    rescue => e
      render :json => "#{e}", :status => :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_region
      @region = Region.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def region_params
      params.require(:region).permit(:name, :status, :createdOn)
    end
end
