class StatusesController < ApplicationController
  # GET /statuses
  # GET /statuses.json
  def index
    @statuses = Status.all

    render json: @statuses
  end

  # GET /statuses/1
  # GET /statuses/1.json
  def show
    @status = Status.find(params[:id])

    render json: @status
  end

  # POST /statuses
  # POST /statuses.json
  def create
    if params[:id]
      @Status = Status.find(params[:id])
      @Status.name=params[:name]
      if @Status.save
        render :json => @Status
      else
        render :json => @Status.errors.full_messages, status: :unprocessable_entity
      end
    else
      @Status = Status.new
      @Status.name=params[:status_name]
      if @Status.save
        render :json => @Status
      else
        render :json => @Status.errors.full_messages, status: :unprocessable_entity
      end
    end
  end

  # PATCH/PUT /statuses/1
  # PATCH/PUT /statuses/1.json
  def update
    @status = Status.find(params[:id])

    if @status.update(params[:status])
      head :no_content
    else
      render json: @status.errors, status: :unprocessable_entity
    end
  end

  # DELETE /statuses/1
  # DELETE /statuses/1.json
  def destroy
    @Status = Status.find(params[:id])
    begin
      if(@Status.destroy)
        render :json =>'Successfully'
      end
    rescue => e
      render :json => "#{e}", :status => :unprocessable_entity
    end
  end
end
