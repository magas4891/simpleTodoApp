class Task < ApplicationRecord
  belongs_to :project

  after_destroy :reorder

  validates_presence_of :project, :description, :position
  validates :description, uniqueness: { scope: :project_id }

  def reorder
    project.tasks.order(position: :asc).map.with_index do |val, ind|
      val.update(position: ind)
    end
  end
end
