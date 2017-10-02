class User < ApplicationRecord
	has_many :user_tasks
	has_many :tasks, through: :user_tasks
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def has_completed_this_task? task
  	user_task = UserTask.where(user: self, task: task).last
  	if self.tasks.include?(task) and user_task.complete?
  		true
  	else
  		false
  	end
  end
end
