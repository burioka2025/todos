class ProjectsController < ApplicationController

  def index
    @projects = Project.all
  end

  def update
  end

  def create
    @project = Project.new(project_params)
  
    respond_to do |format|
      if @project.save
        format.html { redirect_to project_url(@project), notice: "project was successfully created." }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def new
    @project = Project.new
  end

  def edit
  end

  def destroy
  end

  def show
  end

  private
    def project_params
      params.require(:project).permit(:name, :explanation)
    end
end
