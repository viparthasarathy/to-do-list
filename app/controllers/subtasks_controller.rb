class SubtasksController < ApplicationController

  post '/subtasks' do
    task = current_user.tasks.find(params[:task_id])
    subtask = Subtask.new(params[:subtask])
    if subtask.save
      task.subtasks << subtask
      flash[:success] = "Subtask created."
    else
      flash[:error] = "Please enter details of subtask."
    end
    redirect to '/home'
  end

  patch '/subtasks/:id' do
    subtask = current_user.subtasks.find(params[:id])
    flash[:success] = subtask.update(details: params[:details]) ? "Subtask successfully edited." : "Please enter valid details."
    redirect to '/home'
  end

  delete '/subtasks/:id/delete' do
    subtask = current_user.subtasks.find(params[:id])
    subtask.delete
    flash[:success] = "Subtask deleted."
    redirect to '/home'
  end

  post '/subtasks/:id/completed' do
    subtask = current_user.subtasks.find(params[:id])
    subtask.update(completed: true)
    flash[:success] = "Subtask marked as completed."
    redirect to '/home'
  end

  post '/subtasks/:id/uncompleted' do
    subtask = current_user.subtasks.find(params[:id])
    subtask.update(completed: false)
    flash[:success] = "Subtask marked as uncompleted."
    redirect to '/home'
  end

end
