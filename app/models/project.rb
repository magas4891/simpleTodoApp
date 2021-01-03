class Project < ApplicationRecord
  belongs_to :user
  has_many :tasks, dependent: :destroy

  validates_presence_of :name
  validates :name, uniqueness: true

  def task_counter
    self.tasks.count
  end
end
