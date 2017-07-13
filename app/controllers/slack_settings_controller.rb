class SlackSettingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_slack_setting, only: %i[show edit update destroy]

  # GET /slack_settings/1
  # GET /slack_settings/1.json
  def show; end

  # GET /slack_settings/new
  def new
    authorize :slack_setting, :new?

    @slack_setting = SlackSetting.new(project_id: params[:project_id])
  end

  # GET /slack_settings/1/edit
  def edit; end

  # POST /slack_settings
  # POST /slack_settings.json
  def create
    @slack_setting = SlackSetting.new(slack_setting_params)
    authorize @slack_setting
    respond_to do |format|
      if @slack_setting.save
        format.html { redirect_to @slack_setting.project, notice: 'Slack settings where successfully updated.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /slack_settings/1
  # PATCH/PUT /slack_settings/1.json
  def update
    respond_to do |format|
      if @slack_setting.update(slack_setting_params)
        format.html { redirect_to @slack_setting.project, notice: 'Slack settings where successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /slack_settings/1
  # DELETE /slack_settings/1.json
  def destroy
    @slack_setting.destroy
    respond_to do |format|
      format.html { redirect_to @slack_setting.project, notice: 'Slack notifications where successfully disabled.' }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_slack_setting
    @slack_setting = SlackSetting.find(params[:id])
    authorize @slack_setting
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def slack_setting_params
    params.require(:slack_setting).permit(:webhook_url, :channel, :username, :project_id)
  end
end
