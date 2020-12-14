class ProjectsController < ApplicationController
    respond_to :js

    def create
        @project = Project.new(project_params)
        @project.save
    end

    def update
        project = Project.find(params[:id])
        project.update(project_params)
    end

    def destroy
        project = Project.find(params[:id])
        project.destroy
    end

    private
    def project_params
        params.require(:project).permit(:name)
    end

end
