class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: %i[show destroy]

  # GET /projects
  # GET /projects.json
  def index
    @projects = policy_scope(Project)
  end

  # GET /projects/1
  # GET /projects/1.json
  def show; end

  # GET /projects/new
  def new
    authorize :project, :new?

    @project = Project.new
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)
    authorize @project

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    ModelDeleteJob.perform_later(@project)

    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_project
    @project = Project.find(params[:id])
    authorize @project
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def project_params
    params.require(:project).permit(:name).merge(organisation: current_user.organisation)
  end
end
