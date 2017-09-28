class UsersController < ApplicationController
  before_action :set_user, only: %i[destroy]
  skip_before_action :authenticate_user!, only: %i[new create]

  # GET /users
  # GET /users.json
  def index
    @users = policy_scope(User)
  end

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
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
