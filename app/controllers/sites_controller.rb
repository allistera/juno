class SitesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_site, only: %i[show checks destroy checks]

  # GET /sites/1
  # GET /sites/1.json
  def show; end

  # GET /sites/new
  def new
    authorize :site, :new?

    @site = Site.new(project_id: params[:project].to_i, site_type: params[:site_type].to_s)
  end

  # GET /sites/1/checks
  def checks
    render json: grouped_checks
  end

  # POST /sites
  # POST /sites.json
  def create
    # Concat protocol and url
    @site = Site.new(site_create_params)
    authorize @site

    respond_to do |format|
      if @site.save
        format.html { redirect_to @site, notice: 'Site was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # DELETE /sites/1
  # DELETE /sites/1.json
  def destroy
    ModelDeleteJob.perform_later(@site)
    respond_to do |format|
      format.html { redirect_to project_url(@site.project), notice: 'Site was successfully destroyed.' }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_site
    @site = Site.find(params[:id] || params[:site_id])
    authorize @site
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def site_params
    params.require(:site).permit(:name, :protocol, :url, :project_id, :verify_ssl, :custom_status, :basic_auth_username,
                                 :basic_auth_password, :site_type)
  end

  def site_create_params
    return site_params if site_params[:site_type] == 'ping'

    http_params(site_params)
  end

  def http_params(params)
    url = params[:protocol] && params[:url] ? params[:protocol] + params[:url] : nil
    params.merge(url: url).except(:protocol)
  end

  def grouped_checks
    Groupdate.time_zone = false

    @site.checks.group_by_period(
      chart_config['period'],
      :created_at,
      series: false,
      format: chart_config['format'],
      range: chart_config['range_from'].to_time(:utc)..Time.now.utc
    ).average(:time)
  end

  def chart_config
    Rails.application.config_for(:chart)[params[:range].nil? ? 'second' : params[:range]]
  end
end
