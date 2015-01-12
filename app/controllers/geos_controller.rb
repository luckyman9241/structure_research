class GeosController < ApplicationController
  # GET /geos
  # GET /geos.json
  def index
    @geos = Geo.all

    render json: @geos
  end

  # GET /geos/1
  # GET /geos/1.json
  def show
    @geo = Geo.find(params[:id])

    render json: @geo
  end

  # POST /geos
  # POST /geos.json
  def create
    if params[:id]
      @geo = Geo.find(params[:id])
      @geo.name = params[:name]
      @geo.description = params[:description]
      @geo.status = 1
     if @geo.save
        render :json => @geo
      else
        render :json => @geo.errors.full_messages, status: :unprocessable_entity
      end
    else
      @geo = Geo.new
      @geo.name = params[:geo_name]
      @geo.description = params[:geo_desc]
      @geo.status = 1
     if @geo.save
        render :json => @geo
      else
        render :json => @geo.errors.full_messages, status: :unprocessable_entity
      end
    end 
    
  end

  # PATCH/PUT /geos/1
  # PATCH/PUT /geos/1.json
  def update
    @geo = Geo.find(params[:id])

    if @geo.update(params[:geo])
      head :no_content
    else
      render json: @geo.errors, status: :unprocessable_entity
    end
  end

  # DELETE /geos/1
  # DELETE /geos/1.json
  def destroy
    @Geo = Geo.find(params[:id])
    begin
      if(@Geo.destroy)
        render :json =>'Successfully'
      end
    rescue => e
      render :json => "#{e}", :status => :unprocessable_entity
    end
  end
end
