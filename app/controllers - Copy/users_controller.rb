class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  def index
    @users = User.all

    render json: @users
  end


  


  # POST /users/authenticate
  def authenticate
    require 'digest/sha1'
    @password = Digest::SHA1.hexdigest(params[:password])

    @user = User.all(:conditions => {:username => params[:username].downcase, :password => @password})

    if @user.count > 0
      render :json => @user, :status=>:ok
    else
      render :json => "No user found.".to_json ,:status=>:unprocessable_entity
    end
    
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    render json: @user
  end

  # POST /users
  # POST /users.json
  def create
    @password = Digest::SHA1.hexdigest(params[:user_password])
    @user = User.new
    @user.fullname = params[:user_fullName]
    @user.username = params[:user_username]
    @user.password = @password
    @user.user_type_id = params[:user_selected_type]
    @user.status = 1
    if @user.save
        render :json => @user.to_json(:include =>[:user_type])
      else
        render :json => @user.errors.full_messages, status: :unprocessable_entity
      end
    

  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @user = User.find(params[:id])

    if @user.update(params[:user])
      head :no_content
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    head :no_content
  end
end
