class TasksController < ApplicationController
  def create
    project = Project.find(params[:task][:project_id])
    @task = project.tasks.create(task_params)
    respond_to do |format|
      format.js
    end
  end

  def update
    pp "*"*50, params
    @task = Task.find(params[:id])
    @task.update(task_params)
    respond_to do |format|
      format.js
    end
  end

  private
  def task_params
    params.require(:task).permit!
  end
end
