class OrganisationsController < ApplicationController
  before_action :set_organisation, only: %i[show edit update destroy]

  # GET /organisations
  # GET /organisations.json
  def index
    @organisations = policy_scope(Organisation)
  end

  # GET /organisations/new
  def new
    authorize :organisation, :new?
    @organisation = Organisation.new
  end

  # POST /organisation
  # POST /organisation.json
  def create
    @organisation = Organisation.new(organisation_params)
    authorize @organisation

    respond_to do |format|
      if @organisation.save
        format.html { redirect_to organisations_path, notice: 'Organisation was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # DELETE /organisations/1
  # DELETE /organisations/1.json
  def destroy
    @organisation.destroy
    respond_to do |format|
      format.html { redirect_to organisations_url, notice: 'Organisation was successfully destroyed.' }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_organisation
    @organisation = Organisation.find(params[:id])
    authorize @organisation
  end

  def organisation_params
    params.require(:organisation).permit(:name)
  end
end
