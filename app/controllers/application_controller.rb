require_relative '../../config/environment.rb'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "todolist"
    register Sinatra::Flash
  end

  get '/' do
    if logged_in?
      flash[:success] = "Welcome back."
      redirect to '/home'
    else
      redirect to '/login'
    end
  end

  helpers do

    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find_by_id(session[:user_id])
    end
  end

end
