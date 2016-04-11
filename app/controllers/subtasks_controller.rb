class SubtasksController < ApplicationController

  post '/subtasks' do
    task = Task.find(params[:task_id])
    subtask = Subtask.new(params[:subtask])
    task.subtasks << subtask if task.user == current_user && subtask.save
    redirect to "/tasks/#{task.id}"
  end

  delete '/subtasks/:id/delete' do
    subtask = Subtask.find(params[:id])
    task_id = subtask.task_id
    subtask.delete if subtask.user == current_user
    redirect to "/tasks/#{task_id}"
  end

  post '/subtasks/:id/completed' do
    subtask = Subtask.find(params[:id])
    task_id = subtask.task_id
    subtask.update(completed: true) if subtask.user == current_user
    redirect to "/tasks/#{task_id}"
  end

  post '/subtasks/:id/uncompleted' do
    subtask = Subtask.find(params[:id])
    task_id = subtask.task_id
    subtask.update(completed: false) if subtask.user == current_user
    redirect to "/tasks/#{task_id}"
  end

end
