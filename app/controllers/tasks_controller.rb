class TasksController < ApplicationController

  get '/home' do
    if logged_in?
      @tasks = current_user.tasks
      erb :'/tasks/index'
    else
      redirect to '/login'
    end
  end

  get '/tasks/new' do
    if logged_in?
      erb :'/tasks/new'
    else
      redirect to '/login'
    end
  end

  post '/tasks' do
    task = Task.new(params[:task])
    if logged_in? && task.save
      current_user.tasks << task
      params[:subtask].each { |details| task.subtasks << Subtask.create(details) unless details.blank? }
      redirect to "/tasks/#{task.id}"
    else
      redirect to '/tasks/new'
    end
  end

  get '/tasks/:id' do
    @task = Task.find(params[:id])
    if logged_in? && current_user == @task.user
      erb :'/tasks/show'
    else
      redirect to '/home'
    end
  end

  get '/tasks/:id/edit' do
    @task = Task.find(params[:id])
    if logged_in? && current_user == @task.user
      erb :'/tasks/edit'
    else
      redirect to '/home'
    end
  end

  patch '/tasks/:id' do
    task = Task.find(params[:id])
    if logged_in? && current_user == task.user
      task.update(taskname: params[:taskname])
      redirect to "/tasks/#{task.id}"
    else
      redirect to '/home'
    end
  end

  delete '/tasks/:id/delete' do
    task = Task.find(params[:id])
    if logged_in? && current_user == task.user
      task.subtasks.delete
      task.delete
    end
    redirect to '/home'
  end

end
