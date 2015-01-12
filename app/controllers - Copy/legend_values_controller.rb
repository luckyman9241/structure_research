class LegendValuesController < ApplicationController
  # GET /legend_values
  # GET /legend_values.json
  def index
    @legend_values = LegendValue.all

    render json: @legend_values
  end

  # GET /legend_values/1
  # GET /legend_values/1.json
  def show
    @legend_value = LegendValue.find(params[:id])

    render json: @legend_value
  end

  # POST /legend_values
  # POST /legend_values.json
  def create
    if params[:id]
      @legend_value = LegendValue.find(params[:id])
      @legend_value.legend_id= params[:legend_id]
      @legend_value.range= params[:range]
      @legend_value.value= params[:value]
      @legend_value.status =1
      @legend_value.save
      render :json => @legend_value
    else
      @legend_value = LegendValue.new
      @legend_value.legend_id= params[:selected_currency_ID]
      @legend_value.range= params[:currency_percent]
      @legend_value.value= params[:currency_percent_value]
      @legend_value.status =1
      @legend_value.save
      render :json => @legend_value
    end 
  end

  # PATCH/PUT /legend_values/1
  # PATCH/PUT /legend_values/1.json
  def update
    @legend_value = LegendValue.find(params[:id])

    if @legend_value.update(params[:legend_value])
      head :no_content
    else
      render json: @legend_value.errors, status: :unprocessable_entity
    end
  end

  # DELETE /legend_values/1
  # DELETE /legend_values/1.json
  def destroy
    @LegendValue = LegendValue.find(params[:id])
    begin
      if(@LegendValue.destroy)
        render :json =>'Successfully'
      end
    rescue => e
      render :json => "#{e}", :status => :unprocessable_entity
    end
  end
end
