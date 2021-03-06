# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show update destroy]
  skip_before_action :authenticate_user!, only: %i[new create]

  # GET /users
  # GET /users.json
  def index
    @users = policy_scope(User)
  end

  # GET /users/1
  def show; end

  # GET /users/new
  def new
    authorize :user, :new?
    @user = User.new
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(users_params)
    authorize @user

    respond_to do |format|
      if @user.save
        format.html { redirect_to new_user_session_path, notice: 'User was successfully created, please login.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(users_update_params)
        format.html { redirect_to users_path, notice: 'User was successfully updated.' }
        format.json {}
      else
        format.html { render :show }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
    authorize @user
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def users_params
    params.require(:user).permit(:name, :email, :password, :terms_and_conditions)
  end

  def users_update_params
    params.require(:user).permit(:name, :email, :organisation_id, :admin, :platform_admin)
  end
end
