class ProbesController < ApplicationController
  before_action :authenticate_user!, except: %i[create]
  before_action :authenticate, except: %i[index health]
  skip_before_action :verify_authenticity_token, except: [:index]

  # GET /probes
  # GET /probes.json
  def index
    authorize :probe, :index?
    @probes = policy_scope(Probe)
  end

  # POST /probes
  def create
    @probe = Probe.where(probe_params).first_or_create
    authorize @probe

    return render json: @probe, status: :created if @probe.save

    render json: { message: 'Validation error' }, status: :bad_request
  end

  # GET /probes/health/1
  def health
    @probe = Probe.find(params[:id])
    authorize @probe, :show?
    render json: { status: HTTParty.get(@probe.url + '/v1/healthcheck').success? }
  rescue Errno::ECONNREFUSED
    render json: { status: false }
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def probe_params
    params.require(:probe).permit(:name, :url)
  end

  def authenticate
    authenticate_or_request_with_http_token do |token, _options|
      ActiveSupport::SecurityUtils.secure_compare(
        token,
        ENV['JUNO_PROBE_SECRET']
      )
    end
  end
end
