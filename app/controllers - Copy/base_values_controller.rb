class BaseValuesController < ApplicationController
  # GET /base_values
  # GET /base_values.json
  def index
    @base_values = BaseValue.all

    render json: @base_values
  end

  # GET /base_values/1
  # GET /base_values/1.json
  def show
    @base_value = BaseValue.find(params[:id])

    render json: @base_value
  end

  # POST /base_values
  # POST /base_values.json
  def create
    @base_value = BaseValue.new(params[:base_value])

    if @base_value.save
      render json: @base_value, status: :created, location: @base_value
    else
      render json: @base_value.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /base_values/1
  # PATCH/PUT /base_values/1.json
  def update
    @base_value = BaseValue.find(params[:id])

    if @base_value.update(params[:base_value])
      head :no_content
    else
      render json: @base_value.errors, status: :unprocessable_entity
    end
  end

  # DELETE /base_values/1
  # DELETE /base_values/1.json
  def destroy
    @base_value = BaseValue.find(params[:id])
    @base_value.destroy

    head :no_content
  end
end
