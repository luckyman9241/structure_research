class RevenuesController < ApplicationController
  # GET /revenues
  # GET /revenues.json
  def index
    @revenues = Revenue.all

    render json: @revenues
  end

  # GET /revenues/1
  # GET /revenues/1.json
  def show
    @revenue = Revenue.find(params[:id])

    render json: @revenue
  end

  # POST /revenues
  # POST /revenues.json
  def create
    if params[:id]
      @revenue = Revenue.find(params[:id])
      @revenue.name = params[:name];
      @revenue.description = params[:description];
      @revenue.status = 1;
      if @revenue.save
        render :json => @revenue
      else
        render :json => @revenue.errors.full_messages, status: :unprocessable_entity
      end
    else
      @revenue = Revenue.new
      @revenue.name = params[:revenue_name];
      @revenue.description = params[:revenue_desc];
      @revenue.status = 1;
      if @revenue.save
        render :json => @revenue
      else
        render :json => @revenue.errors.full_messages, status: :unprocessable_entity
      end
    end
  end

  # PATCH/PUT /revenues/1
  # PATCH/PUT /revenues/1.json
  def update
    @revenue = Revenue.find(params[:id])

    if @revenue.update(params[:revenue])
      head :no_content
    else
      render json: @revenue.errors, status: :unprocessable_entity
    end
  end

  # DELETE /revenues/1
  # DELETE /revenues/1.json
  def destroy
    @Revenue = Revenue.find(params[:id])
    begin
      if(@Revenue.destroy)
        render :json =>'Successfully'
      end
    rescue => e
      render :json => "#{e}", :status => :unprocessable_entity
    end
  end
end
