require_relative '../../config/environment.rb'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "todolist"
  end

  get '/' do
    "Hello World!"
  end
  
  helpers do

    def logged_in?
      !!session[:user_id]
    end

    def current_user
    end

  end
end
