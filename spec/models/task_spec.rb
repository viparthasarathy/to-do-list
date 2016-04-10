require 'spec_helper'

describe 'Task' do
  before do
    @user = User.create(username: "Bobby Jims", password: "itsbobby")
    @task = Task.create(taskname: "Cook Dinner")
    @user.tasks << @task
    @user.tasks << Task.create(taskname: "Pick up Bobby Jr.")
    @task.subtasks << Subtask.create(details: "Pick up groceries.")
    @task.subtasks << Subtask.create(details: "Cook.")
  end

  it 'can be initialized' do
    expect(@task).to be_an_instance_of(Task)
  end

  it 'belongs to a user' do
    expect(@task.user).to eq(@user)
  end

  it 'has a taskname' do
    expect(@task.taskname).to eq("Cook Dinner")
  end

  it 'can have many subtasks' do
    expect(@task.subtasks.count).to eq(2)
  end
end
