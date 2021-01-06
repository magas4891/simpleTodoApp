# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :authenticate_user!, :set_projects
  respond_to :js

  def create
    @project = current_user.projects.build(project_params)
    @project.save
  end

  def update
    @project = Project.find(params[:id])
    @project.update(project_params)
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
  end

  private

  def project_params
    params.require(:project).permit(:name, :deadline)
  end

  def set_projects
    @projects = current_user.projects.order(created_at: :asc)
  end
end
