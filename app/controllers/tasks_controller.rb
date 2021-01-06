# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :authenticate_user!

  def create
    @project = Project.find(params[:task][:project_id])
    task = @project.tasks.build(task_params)
    task.position = @project.task_counter
    task.save!
    @tasks = @project.tasks.order(position: :asc)
  end

  def update
    task = Task.find(params[:id])
    task.update(task_params)
    @project = task.project
    @tasks = task.project.tasks.order(position: :asc)
  end

  def destroy
    task = Task.find(params[:id])
    task.destroy
    @project = task.project
    @tasks = task.project.tasks.order(position: :asc)
  end

  private

  def task_params
    params.require(:task).permit(:description, :done, :position)
  end
end
