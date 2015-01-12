class AnalystsController < ApplicationController
  # GET /analysts
  # GET /analysts.json
  def index
    @analysts = Analyst.all

    render json: @analysts
  end

  # GET /analysts/1
  # GET /analysts/1.json
  def show
    @analyst = Analyst.find(params[:id])

    render json: @analyst
  end

  # POST /analysts
  # POST /analysts.json
  def create
    if params[:id]
      @Analyst = Analyst.find(params[:id])
      @Analyst.name=params[:name]
      if @Analyst.save
        render :json => @Analyst
      else
        render :json => @Analyst.errors.full_messages, status: :unprocessable_entity
      end
    else
      @Analyst = Analyst.new
      @Analyst.name=params[:analyst_name]
      if @Analyst.save
        render :json => @Analyst
      else
        render :json => @Analyst.errors.full_messages, status: :unprocessable_entity
      end
    end
  end

  # PATCH/PUT /analysts/1
  # PATCH/PUT /analysts/1.json
  def update
    @analyst = Analyst.find(params[:id])

    if @analyst.update(params[:analyst])
      head :no_content
    else
      render json: @analyst.errors, status: :unprocessable_entity
    end
  end

  # DELETE /analysts/1
  # DELETE /analysts/1.json
  def destroy
    @Analyst = Analyst.find(params[:id])
    begin
      if(@Analyst.destroy)
        render :json =>'Successfully'
      end
    rescue => e
      render :json => "#{e}", :status => :unprocessable_entity
    end
  end
end
