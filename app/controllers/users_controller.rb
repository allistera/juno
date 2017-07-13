class UsersController < ApplicationController
  before_action :set_user, only: %i[destroy]

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
end
