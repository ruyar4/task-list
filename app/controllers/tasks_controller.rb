class TasksController < ApplicationController
	before_action :authenticate_user!
	before_action :set_task, only: [:complete_task, :show]

	def index
		@tasks = Task.all
	end

	def show
		@users = User.joins(:user_tasks).where(user_tasks: {complete: true})
		@top_five = @users.order("updated_at asc").uniq.first(5)
	end

	def complete_task
		if current_user.has_completed_this_task?(@task)
			user_task = UserTask.where(user: current_user, task: @task, complete: true).first
			user_task.not_completed
			redirect_to root_path, alert: "Esta tarea ya no esta completada"
		else
			user_task = UserTask.create(user: current_user, task: @task)
			user_task.complete_task
			redirect_to root_path, notice: "Tarea Completada"
		end
	end

	private

	def set_task
		if params[:id]
			@task = Task.find(params[:id])
		else
			@task = Task.find(params[:task_id])
		end
	end
end
