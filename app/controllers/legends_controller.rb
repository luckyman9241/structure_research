class LegendsController < ApplicationController
  before_action :set_legend, only: [:show, :edit, :update, :destroy]

  # GET /legends
  # GET /legends.json
  def index
    @legends = Legend.all
  end

  # GET /legends/1
  # GET /legends/1.json
  def show
  end

  # GET /legends/new
  def new
    @legend = Legend.new
  end

  # GET /legends/1/edit
  def edit
  end

  # POST /legends
  # POST /legends.json
  def create
    if params[:id]
      @legend = Legend.find(params[:id])
      @legend.FX_rate =params[:FX_rate];
      @legend.currency =params[:currency];
      @legend.name =params[:name];
      @legend.currency_prefix =params[:currency_prefix];
      @legend.status =1;
      @legend.createdOn = Time.now.getutc;
      if @legend.save
        render :json => @legend
      else
        render :json => @legend.errors.full_messages, status: :unprocessable_entity
      end
    else
      @legend = Legend.new
      @legend.FX_rate =params[:fxrate];
      @legend.currency =params[:currency];
      @legend.name =params[:currencyName];
      @legend.currency_prefix =params[:currencyPrefix];
      @legend.status =1;
      @legend.createdOn = Time.now.getutc;
      if @legend.save
        render :json => @legend
      else
        render :json => @legend.errors.full_messages, status: :unprocessable_entity
      end
    end 
    
  end

  # PATCH/PUT /legends/1
  # PATCH/PUT /legends/1.json
  def update
    respond_to do |format|
      if @legend.update(legend_params)
        format.html { redirect_to @legend, notice: 'Legend was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @legend.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /legends/1
  # DELETE /legends/1.json
  def destroy
    @Legend = Legend.find(params[:id])
    begin
      if(@Legend.destroy)
        render :json =>'Successfully'
      end
    rescue => e
      render :json => "#{e}", :status => :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_legend
      @legend = Legend.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def legend_params
      params.require(:legend).permit(:FX_rate, :currency, :name, :year_avg_id, :currency_prefix, :status, :createdOn)
    end
end
