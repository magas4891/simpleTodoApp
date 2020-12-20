class Task < ApplicationRecord
  belongs_to :project

  after_destroy :reorder

  def reorder
    project.tasks.order(position: :asc).map.with_index do |val, ind|
      val.update(position: ind)
    end
  end
end
