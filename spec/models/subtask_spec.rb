require 'spec_helper'

describe "Subtask" do
  before do
    @user = User.create(username: "Bobby Jims", password: "itsbobby")
    @task = Task.create(taskname: "Cook Dinner")
    @subtask = Subtask.create(details: "Pick up groceries.")
    @user.tasks << @task
    @user.tasks << Task.create(taskname: "Pick up Bobby Jr.")
    @task.subtasks << @subtask
    @task.subtasks << Subtask.create(details: "Cook.")
  end

  it 'can initialized' do
    expect(@subtask).to be_an_instance_of(Subtask)
  end

  it 'has details' do
    expect(@subtask.details).to eq("Pick up groceries.")
  end

  it 'belongs to a task' do
    expect(@subtask.task).to eq(@task)
  end

  it 'belongs to a user' do
    expect(@subtask.user).to eq(@user)
  end

end
