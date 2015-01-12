class PercentRangesController < ApplicationController
  before_action :set_percent_range, only: [:show, :edit, :update, :destroy]

  # GET /percent_ranges
  # GET /percent_ranges.json
  def index
    @percent_ranges = PercentRange.all
    render :json => @percent_ranges, :status=>:ok
  end

  # GET /percent_ranges/1
  # GET /percent_ranges/1.json
  def show
  end

  # GET /percent_ranges/new
  def new
    @percent_range = PercentRange.new
  end

  # GET /percent_ranges/1/edit
  def edit
  end

  # POST /percent_ranges
  # POST /percent_ranges.json
  def create
    if params[:id]
      @PercentRange = PercentRange.find(params[:id])
      @PercentRange.range =params[:range];
      @PercentRange.value =params[:value];
      @PercentRange.status =1;
      @PercentRange.createdOn = Time.now.getutc;
      @PercentRange.save;
      render :json => @PercentRange
    else
      @PercentRange = PercentRange.new
      @PercentRange.range =params[:per_range];
      @PercentRange.value =params[:per_val];
      @PercentRange.status =1;
      @PercentRange.createdOn = Time.now.getutc;
      @PercentRange.save;
      render :json => @PercentRange
    end 
    
  end

  # PATCH/PUT /percent_ranges/1
  # PATCH/PUT /percent_ranges/1.json
  def update
    respond_to do |format|
      if @percent_range.update(percent_range_params)
        format.html { redirect_to @percent_range, notice: 'Percent range was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @percent_range.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /percent_ranges/1
  # DELETE /percent_ranges/1.json
  def destroy
    @PercentRange = PercentRange.find(params[:id])
    begin
      if(@PercentRange.destroy)
        render :json =>'Successfully'
      end
    rescue => e
      render :json => "#{e}", :status => :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_percent_range
      @percent_range = PercentRange.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def percent_range_params
      params.require(:percent_range).permit(:value, :range, :status, :createdOn)
    end
end
