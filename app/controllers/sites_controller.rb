class SitesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_site, only: %i[show edit update destroy]
  before_action :construct_chart, only: %i[show]

  # GET /sites
  # GET /sites.json
  def index
    @sites = Site.all
  end

  # GET /sites/1
  # GET /sites/1.json
  def show; end

  # GET /sites/new
  def new
    @site = Site.new(project_id: params[:project].to_i)
  end

  # GET /sites/1/edit
  def edit; end

  # POST /sites
  # POST /sites.json
  def create
    @site = Site.new(site_params)

    respond_to do |format|
      if @site.save
        format.html { redirect_to @site, notice: 'Site was successfully created.' }
        format.json { render :show, status: :created, location: @site }
      else
        format.html { render :new }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sites/1
  # PATCH/PUT /sites/1.json
  def update
    respond_to do |format|
      if @site.update(site_params)
        format.html { redirect_to @site, notice: 'Site was successfully updated.' }
        format.json { render :show, status: :ok, location: @site }
      else
        format.html { render :edit }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sites/1
  # DELETE /sites/1.json
  def destroy
    ModelDeleteJob.perform_later(@site)
    respond_to do |format|
      format.html { redirect_to project_url(@site.project), notice: 'Site was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_site
    @site = Site.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def site_params
    params.require(:site).permit(:name, :url, :project_id, :verify_ssl)
  end

  # rubocop:disable Metrics/MethodLength
  def construct_chart
    checks = @site.checks.last(20)

    @data = {
      labels: checks.map { |check| check.created_at.to_formatted_s(:short) },
      datasets: [
        {
          label: 'Response Time',
          data: checks.map { |check| (check.time * 1000).round },
          fill: false,
          pointBackgroundColor: 'green',
          borderColor: 'green'
        }
      ]
    }
    @options = {
      height: 100,
      legend: {
        display: false
      }
    }
  end
  # rubocop:enable Metrics/MethodLength
end
