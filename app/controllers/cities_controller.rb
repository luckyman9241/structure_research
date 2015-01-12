class CitiesController < ApplicationController
  before_action :set_city, only: [:show, :edit, :update, :destroy]

  # GET /cities
  # GET /cities.json
  def index
    @cities = City.all
  end

  # GET /cities/1
  # GET /cities/1.json
  def show
  end

  # GET /cities/new
  def new
    @city = City.new
  end

  # GET /cities/1/edit
  def edit
  end

  # POST /cities
  # POST /cities.json
  def create
    if params[:id]
      @city = City.find(params[:id])
      @city.name =params[:name];
      @city.status =1;
      @city.createdOn = Time.now.getutc;
      if @city.save
        render :json => @city
      else
        render :json => @city.errors.full_messages, status: :unprocessable_entity
      end
    else
      @city = City.new
      @city.name =params[:city_name];
      @city.status =1;
      @city.createdOn = Time.now.getutc;
      if @city.save
        render :json => @city
      else
        render :json => @city.errors.full_messages, status: :unprocessable_entity
      end
    end 
  end

  # PATCH/PUT /cities/1
  # PATCH/PUT /cities/1.json
  def update
    respond_to do |format|
      if @city.update(city_params)
        format.html { redirect_to @city, notice: 'City was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @city.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cities/1
  # DELETE /cities/1.json
  def destroy
    @City = City.find(params[:id])
    begin
      if(@City.destroy)
        render :json =>'Successfully'
      end
    rescue => e
      render :json => "#{e}", :status => :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_city
      @city = City.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def city_params
      params.require(:city).permit(:name, :status, :createdOn)
    end
end
