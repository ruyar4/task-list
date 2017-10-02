class UserTask < ApplicationRecord
  belongs_to :user
  belongs_to :task

  scope :completeds, lambda{ where(complete: true) }

  def complete_task
  	self.complete = true
  	self.save
  end

  def not_completed
  	self.complete = false
  	self.save
  end
end
