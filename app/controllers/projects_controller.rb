class ProjectsController < ApplicationController
    def index
        @projects = Project.all
        @project = Project.new
        @tasks = @project.tasks
    end

    def create
        @project = Project.new(project_params)
        @project.save
        respond_to do |format|
            format.html { redirect_to @project, notice: 'User was successfully created.' }
            format.js
            format.json { render json: @project, status: :created, location: @project }
        end
    end

    private
    def project_params
        params.require(:project).permit(:name)
    end

end
