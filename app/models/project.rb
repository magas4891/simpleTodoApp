class Project < ApplicationRecord
  has_many :tasks, dependent: :destroy

  def task_counter
    self.tasks.count
  end
end
