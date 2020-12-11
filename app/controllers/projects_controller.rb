class ProjectsController < ApplicationController
    def index
        @projects = Project.all
    end

    def create
        @project = Project.new(project_params)
        @project.save
        respond_to do |format|
            format.js
        end
    end

    def destroy
        project.destroy
        @projects = Project.all
        respond_to do |format|
            format.js
        end
    end

    private
    def project_params
        params.require(:project).permit(:name)
    end

end
