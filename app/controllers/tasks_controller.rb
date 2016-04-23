class TasksController < ApplicationController

  get '/home' do
    redirect_if_logged_out
    @tasks = current_user.tasks
    erb :'/tasks/index'
  end

  post '/tasks' do
    task = Task.new(params[:task])
    if task.save
      current_user.tasks << task
      params[:subtask].each { |details| task.subtasks << Subtask.create(details) unless details.blank? }
      flash[:success] = "New task created."
    else
      flash[:error] = "Please enter taskname."
    end
    redirect to '/home'
  end

  patch '/tasks/:id' do
    task = current_user.tasks.find(params[:id])
    flash[:success] = task.update(taskname: params[:taskname]) ? "Task successfully edited." : "Please enter valid taskname."
    redirect to '/home'
  end

  delete '/tasks/:id/delete' do
    task = current_user.tasks.find(params[:id])
    task.subtasks.delete
    task.delete
    flash[:success] = "Task deleted."
    redirect to '/home'
  end

  post '/tasks/:id/completed' do
    task = current_user.tasks.find(params[:id])
    task.update(completed: true)
    task.subtasks.each {|subtask| subtask.update(completed: true)}
    flash[:success] = "Task set as complete."
    redirect to '/home'
  end

  post '/tasks/:id/uncompleted' do
    task = current_user.tasks.find(params[:id])
    task.update(completed: false)
    flash[:success] = "Task set as uncomplete."
    redirect to '/home'
  end

end
