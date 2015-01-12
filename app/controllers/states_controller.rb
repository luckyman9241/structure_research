class StatesController < ApplicationController
  before_action :set_state, only: [:show, :edit, :update, :destroy]

  # GET /states
  # GET /states.json
  def index
    @states = State.all
  end

  # GET /states/1
  # GET /states/1.json
  def show
  end

  # GET /states/new
  def new
    @state = State.new
  end

  # GET /states/1/edit
  def edit
  end

  # POST /states
  # POST /states.json
  def create
    if params[:id]
      @state = State.find(params[:id])
      @state.name =params[:name]
      @state.status =1
      @state.createdOn = Time.now.getutc
      if @state.save
        render :json => @state
      else
        render :json => @state.errors.full_messages, status: :unprocessable_entity
      end
      
    else
      @state = State.new
      @state.name =params[:state_name];
      @state.status =1;
      @state.createdOn = Time.now.getutc;
      if @state.save
        render :json => @state
      else
        render :json => @state.errors.full_messages, status: :unprocessable_entity
      end
    end 
  end

  # PATCH/PUT /states/1
  # PATCH/PUT /states/1.json
  def update
    respond_to do |format|
      if @state.update(state_params)
        format.html { redirect_to @state, notice: 'State was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @state.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /states/1
  # DELETE /states/1.json
  def destroy
    @State = State.find(params[:id])
    begin
      if(@State.destroy)
        render :json =>'Successfully'
      end
    rescue => e
      render :json => "#{e}", :status => :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_state
      @state = State.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def state_params
      params.require(:state).permit(:name, :status, :createdOn)
    end
end
