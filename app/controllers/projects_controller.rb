class ProjectsController < ApplicationController
    def create
        @project = Project.new(project_params)
        @project.save
        respond_to do |format|
            format.js
        end
    end

    def destroy
        project = Project.find(params[:id])
        project.destroy
        respond_to do |format|
            format.js
        end
    end

    private
    def project_params
        params.require(:project).permit(:name)
    end

end
