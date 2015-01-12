class RevenueRangesController < ApplicationController
  before_action :set_revenue_range, only: [:show, :edit, :update, :destroy]

  # GET /revenue_ranges
  # GET /revenue_ranges.json
  def index
    @revenue_ranges = RevenueRange.all
    render :json => @revenue_ranges, :status=>:ok
  end

  # GET /revenue_ranges/1
  # GET /revenue_ranges/1.json
  def show
  end

  # GET /revenue_ranges/new
  def new
    @revenue_range = RevenueRange.new
  end

  # GET /revenue_ranges/1/edit
  def edit
  end

  # POST /revenue_ranges
  # POST /revenue_ranges.json
  def create
    if params[:id]
      @RevenueRange = RevenueRange.find(params[:id])
      @RevenueRange.range =params[:range];
      @RevenueRange.value =params[:value];
      @RevenueRange.status =1;
      @RevenueRange.createdOn = Time.now.getutc;
      @RevenueRange.save;
      render :json => @RevenueRange
    else
      @RevenueRange = RevenueRange.new
      @RevenueRange.range =params[:rev_range];
      @RevenueRange.value =params[:rev_val];
      @RevenueRange.status =1;
      @RevenueRange.createdOn = Time.now.getutc;
      @RevenueRange.save;
      render :json => @RevenueRange
    end 
  end

  # PATCH/PUT /revenue_ranges/1
  # PATCH/PUT /revenue_ranges/1.json
  def update
    respond_to do |format|
      if @revenue_range.update(revenue_range_params)
        format.html { redirect_to @revenue_range, notice: 'Revenue range was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @revenue_range.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /revenue_ranges/1
  # DELETE /revenue_ranges/1.json
  def destroy
    @RevenueRange = RevenueRange.find(params[:id])
    begin
      if(@RevenueRange.destroy)
        render :json =>'Successfully'
      end
    rescue => e
      render :json => "#{e}", :status => :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_revenue_range
      @revenue_range = RevenueRange.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def revenue_range_params
      params.require(:revenue_range).permit(:value, :range, :status, :createdOn)
    end
end
