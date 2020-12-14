class TasksController < ApplicationController
  respond_to :js

  def create
    project = Project.find(params[:task][:project_id])
    task = project.tasks.create(task_params)
  end

  def update
    task = Task.find(params[:id])
    task.update(task_params)
  end

  def destroy
    task = Task.find(params[:id])
    task.destroy
  end

  private
  def task_params
    params.require(:task).permit!
  end
end
