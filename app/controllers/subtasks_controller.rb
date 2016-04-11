class SubtasksController < ApplicationController

  post '/subtasks' do
    task = Task.find(params[:task_id])
    subtask = Subtask.new(params[:subtask])
    if task.user == current_user && subtask.save
      task.subtasks << subtask
      flash[:success] = "Subtask created."
    else
      flash[:error] = "Please enter details of subtask."
    end
    redirect to "/tasks/#{task.id}"
  end

  delete '/subtasks/:id/delete' do
    subtask = Subtask.find(params[:id])
    task_id = subtask.task_id
    if subtask.user == current_user
      subtask.delete
      flash[:success] = "Subtask deleted."
    else
      flash[:error] = "Not your subtask."
    end
    redirect to "/tasks/#{task_id}"
  end

  post '/subtasks/:id/completed' do
    subtask = Subtask.find(params[:id])
    task_id = subtask.task_id
    if subtask.user == current_user
      subtask.update(completed: true)
      flash[:success] = "Subtask marked as completed."
    else
      flash[:error] = "Not your subtask."
    end
    redirect to "/tasks/#{task_id}"
  end

  post '/subtasks/:id/uncompleted' do
    subtask = Subtask.find(params[:id])
    task_id = subtask.task_id
    if subtask.user == current_user
      subtask.update(completed: false)
      flash[:success] = "Subtask marked as uncompleted."
    else
      flash[:error] = "Not your subtask."
    end
    redirect to "/tasks/#{task_id}"
  end

end
