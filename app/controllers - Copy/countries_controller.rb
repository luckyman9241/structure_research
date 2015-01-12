class CountriesController < ApplicationController
  before_action :set_country, only: [:show, :edit, :update, :destroy]

  # GET /countries
  # GET /countries.json
  def index
    @countries = Country.all
  end

  # GET /countries/1
  # GET /countries/1.json
  def show
  end

  # GET /countries/new
  def new
    @country = Country.new
  end

  # GET /countries/1/edit
  def edit
  end

  # POST /countries
  # POST /countries.json
  def create
    if params[:id]
      @country = Country.find(params[:id])
      @country.name =params[:name];
      @country.status =1;
      @country.createdOn = Time.now.getutc;
      if @country.save
        render :json => @country
      else
        render :json => @country.errors.full_messages, status: :unprocessable_entity
      end
    else
      @country = Country.new
      @country.name =params[:country_name];
      @country.status =1;
      @country.createdOn = Time.now.getutc;
      if @country.save
        render :json => @country
      else
        render :json => @country.errors.full_messages, status: :unprocessable_entity
      end
    end 
  end

  # PATCH/PUT /countries/1
  # PATCH/PUT /countries/1.json
  def update
    respond_to do |format|
      if @country.update(country_params)
        format.html { redirect_to @country, notice: 'Country was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @country.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /countries/1
  # DELETE /countries/1.json
  def destroy
    @country = Country.find(params[:id])
    begin
      if(@country.destroy)
        render :json =>'Successfully'
      end
    rescue => e
      render :json => "#{e}", :status => :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_country
      @country = Country.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def country_params
      params.require(:country).permit(:name, :status, :createdOn)
    end
end
