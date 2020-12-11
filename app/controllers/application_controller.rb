class ApplicationController < ActionController::Base
  before_action :set_projects
  
  private
  def set_projects
    @projects = Project.all
  end
end
