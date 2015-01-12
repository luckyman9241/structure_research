class UserTypesController < ApplicationController
  # GET /user_types
  # GET /user_types.json
  def index
    @user_types = UserType.all

    render json: @user_types
  end

  # GET /user_types/1
  # GET /user_types/1.json
  def show
    @user_type = UserType.find(params[:id])

    render json: @user_type
  end

  # POST /user_types
  # POST /user_types.json
  def create
    @user_type = UserType.new(params[:user_type])

    if @user_type.save
      render json: @user_type, status: :created, location: @user_type
    else
      render json: @user_type.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /user_types/1
  # PATCH/PUT /user_types/1.json
  def update
    @user_type = UserType.find(params[:id])

    if @user_type.update(params[:user_type])
      head :no_content
    else
      render json: @user_type.errors, status: :unprocessable_entity
    end
  end

  # DELETE /user_types/1
  # DELETE /user_types/1.json
  def destroy
    @user_type = UserType.find(params[:id])
    @user_type.destroy

    head :no_content
  end
end
