class TasksController < ApplicationController

  get '/home' do
    erb :'/tasks/index'
  end
