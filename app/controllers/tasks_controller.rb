class TasksController < ApplicationController

  get '/home' do
    if logged_in?
      @tasks = current_user.tasks
      erb :'/tasks/index'
    else
      flash[:error] = "Please log in."
      redirect to '/login'
    end
  end

  get '/tasks/new' do
    if logged_in?
      erb :'/tasks/new'
    else
      flash[:error] = "Please log in."
      redirect to '/login'
    end
  end

  post '/tasks' do
    task = Task.new(params[:task])
    if logged_in? && task.save
      current_user.tasks << task
      params[:subtask].each { |details| task.subtasks << Subtask.create(details) unless details.blank? }
      flash[:success] = "New task created."
      redirect to "/tasks/#{task.id}"
    else
      flash[:error] = "Please enter taskname."
      redirect to '/tasks/new'
    end
  end

  get '/tasks/:id' do
    @task = Task.find(params[:id])
    if current_user == @task.user
      erb :'/tasks/show'
    else
      flash[:error] = "This is not your task."
      redirect to '/home'
    end
  end

  get '/tasks/:id/edit' do
    @task = Task.find(params[:id])
    if current_user == @task.user
      erb :'/tasks/edit'
    else
      flash[:error] = "This is not your task."
      redirect to '/home'
    end
  end

  patch '/tasks/:id' do
    task = Task.find(params[:id])
    if current_user == task.user
      flash[:success] = task.update(taskname: params[:taskname]) ? "Task successfully edited." : "Please enter valid taskname."
      redirect to "/tasks/#{task.id}"
    else
      flash[:error] = "This is not your task."
      redirect to '/home'
    end
  end

  delete '/tasks/:id/delete' do
    task = Task.find(params[:id])
    if current_user == task.user
      task.subtasks.delete
      task.delete
      flash[:success] = "Task deleted."
    else
      flash[:error] = "This is not your task."
    end
    redirect to '/home'
  end

  post '/tasks/:id/completed' do
    task = Task.find(params[:id])
    if current_user == task.user
      task.update(completed: true)
      task.subtasks.each {|subtask| subtask.update(completed: true)}
      flash[:success] = "Task set as complete."
    else
      flash[:error] = "This is not your task."
    end
    redirect to '/home'
  end

  post '/tasks/:id/uncompleted' do
    task = Task.find(params[:id])
    if current_user == task.user
      task.update(completed: false)
      redirect to "/tasks/#{task.id}"
      flash[:success] = "Task set as uncomplete."
    else
      flash[:error] = "This is not your task."
      redirect to "/home"
    end
  end

end
