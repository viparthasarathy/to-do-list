class TasksController < ApplicationController

  get '/home' do
    if logged_in?
      erb :'/tasks/index'
    else
      redirect to '/login'
    end
  end

end
