require 'spec_helper'

describe 'User' do
  before do
    @user = User.create(username: "Bobby Jims", password: "itsbobby")
    @task = Task.create(taskname: "Cook Dinner")
    @user.tasks << @task
    @user.tasks << Task.create(taskname: "Pick up Bobby Jr.")
    @task.subtasks << Subtask.create(details: "Pick up groceries.")
    @task.subtasks << Subtask.create(details: "Cook.")
  end

  it 'can be initialized' do
    expect(@user).to be_an_instance_of(User)
  end

  it 'has a name' do
    expect(@user.username).to eq("Bobby Jims")
  end

  it 'has a secure password' do
    expect(@user.authenticate("dog")).to eq(false)
    expect(@user.authenticate("itsbobby")).to eq(@user)
  end

  it 'can have many tasks' do
    expect(@user.tasks.count).to eq(2)
  end

  it 'has many subtasks' do
    expect(@user.subtasks.count).to eq(2)
  end

  it 'has a unique username' do
    @user2 = User.new(username: "Bobby Jims", password: "itsnotbobby")
    expect(@user2.save).to eq(false)
  end

end
