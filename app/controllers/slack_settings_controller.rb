class SlackSettingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_slack_setting, only: %i[show edit update destroy]

  # GET /slack_settings
  # GET /slack_settings.json
  def index
    @slack_settings = SlackSetting.all
  end

  # GET /slack_settings/1
  # GET /slack_settings/1.json
  def show; end

  # GET /slack_settings/new
  def new
    @slack_setting = SlackSetting.new(project_id: params[:project_id])
  end

  # GET /slack_settings/1/edit
  def edit; end

  # POST /slack_settings
  # POST /slack_settings.json
  def create
    @slack_setting = SlackSetting.new(slack_setting_params)

    respond_to do |format|
      if @slack_setting.save
        format.html { redirect_to @slack_setting.project, notice: 'Slack settings where successfully updated.' }
        format.json { render :show, status: :created, location: @slack_setting }
      else
        format.html { render :new }
        format.json { render json: @slack_setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /slack_settings/1
  # PATCH/PUT /slack_settings/1.json
  def update
    respond_to do |format|
      if @slack_setting.update(slack_setting_params)
        format.html { redirect_to @slack_setting.project, notice: 'Slack settings where successfully updated.' }
        format.json { render :show, status: :ok, location: @slack_setting.project }
      else
        format.html { render :edit }
        format.json { render json: @slack_setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /slack_settings/1
  # DELETE /slack_settings/1.json
  def destroy
    @slack_setting.destroy
    respond_to do |format|
      format.html { redirect_to @slack_setting.project, notice: 'Slack notifications where successfully disabled.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_slack_setting
    @slack_setting = SlackSetting.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def slack_setting_params
    params.require(:slack_setting).permit(:webhook_url, :channel, :username, :project_id)
  end
end
