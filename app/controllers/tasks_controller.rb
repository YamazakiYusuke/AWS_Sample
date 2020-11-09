class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    if params[:task]
      params_sarch_title = params[:task][:sarch_title]
      params_sarch_status = params[:task][:sarch_status]
      if params_sarch_title != "" && params_sarch_status != ""
        @tasks = Task.title_scope(params_sarch_title).status_scope(params_sarch_status).page(params[:page]).per(10)
      elsif params_sarch_title != ""
        @tasks = Task.title_scope(params_sarch_title).page(params[:page]).per(10)
      elsif params_sarch_status != ""
        @tasks = Task.status_scope(params_sarch_status).page(params[:page]).per(10)
      else
        @tasks = Task.all.page(params[:page]).per(10).order(limit: :desc)
      end
    else

      if params["sort_expired"]
        @tasks = Task.all.page(params[:page]).per(10).order(limit: :desc)
      elsif params["sort_priority"]
        @tasks = Task.all.page(params[:page]).per(10).order(priority: :desc)
      else
        @tasks = Task.all.page(params[:page]).per(10).order(created_at: :desc)
      end
    end
  end

  def show
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to tasks_path, notice: '新しいタスクを登録しました' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'タスクの内容を更新しました' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'タスクを削除しました' }
      format.json { head :no_content }
    end
  end

  private
    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:title, :content, :limit, :status)
    end
end
