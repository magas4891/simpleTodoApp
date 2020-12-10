class TasksController < ApplicationController
  def index
    @tasks = Task.all
    @task = Task.new
  end

  def create
    @task = Task.create(task_params)
    respond_to do |format|
      format.html
      format.js
      format.json { render json: @task, status: :created, location: @task }
    end
  end

  private
  def task_params
    params.require(:task).permit!
  end
end
