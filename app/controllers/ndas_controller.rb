class NdasController < ApplicationController
  before_action :set_nda, only: [:show, :edit, :update, :destroy]

  # GET /ndas
  # GET /ndas.json
  def index
    @ndas = Nda.all
  end

  # GET /ndas/1
  # GET /ndas/1.json
  def show
  end

  # GET /ndas/new
  def new
    @nda = Nda.new
  end

  # GET /ndas/1/edit
  def edit
  end

  # POST /ndas
  # POST /ndas.json
  def create
    if params[:id]
      @nda = Nda.find(params[:id])
      @nda.name=params[:name]
      @nda.status=1
      if @nda.save
        render :json => @nda
      else
        render :json => @nda.errors.full_messages, status: :unprocessable_entity
      end
    else
      @nda = Nda.new
      @nda.name=params[:nda_name]
      @nda.status=1
      if @nda.save
        render :json => @nda
      else
        render :json => @nda.errors.full_messages, status: :unprocessable_entity
      end
    end

  end

  # PATCH/PUT /ndas/1
  # PATCH/PUT /ndas/1.json
  def update
    respond_to do |format|
      if @nda.update(nda_params)
        format.html { redirect_to @nda, notice: 'Nda was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @nda.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ndas/1
  # DELETE /ndas/1.json
  def destroy
    @Nda = Nda.find(params[:id])
    begin
      if(@Nda.destroy)
        render :json =>'Successfully'
      end
    rescue => e
      render :json => "#{e}", :status => :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_nda
      @nda = Nda.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def nda_params
      params.require(:nda).permit(:name, :status, :createdOn)
    end
end
