class TasksController < ApplicationController
  before_action :set_task, only:[:show,:edit,:update,:destroy]

  def index
    @tasks = current_user.tasks.order(created_at: :desc)
  end

  def show
  end

  def edit
  end

  def new
    @task = Task.new
  end
  
  def create
    @task = Task.new(task_params.merge(user_id: current_user.id))

    if @task.save
      redirect_to @task, notice: "フレンド「#{@task.name}」を募集しました！"
    else
      render :new  
    end
  end

  def update
    task.update!(task_params)
    redirect_to tasks_url,notice: "募集内容を更新しました！"
  end

  def destroy
    task.destroy
    redirect_to tasks_url, notice: "募集内容を削除しました。"
  end

  private

  def task_params
    params.require(:task).permit(:name, :description)
  end

  def set_task
    @task = current_user.tasks.find(params[:id])
  end
end
