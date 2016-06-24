require_relative '../../config/environment.rb'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "todolist"
    register Sinatra::Flash
  end

  helpers do

    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end

    def logout!
      session.clear
    end

    def log_in(user_details)
      user = User.find_by(username: user_details[:username])
      if user && user.authenticate(user_details[:password])
        session[:user_id] = user.id
        flash[:success] = "Welcome back."
        redirect to '/home'
      else
        flash[:error] = "Incorrect username and/or password."
        redirect to '/'
      end
    end

    def sign_up(user_details)
      user = User.new(user_details)
      if user.save
        session[:user_id] = user.id
        flash[:success] = "Signed up!"
        redirect to '/home'
      elsif (user_details[:username] == "" || user_details[:password] == "")
        flash[:error] = "Please enter a username and password."
        redirect to '/'
      else
        flash[:error] = "Username is taken."
        redirect to '/'
      end
    end

    def redirect_if_logged_in
      if logged_in?
        flash[:error] = "Already logged in."
        redirect to '/home'
      end
    end

    def redirect_if_logged_out
      if !logged_in?
        flash[:error] = "Not logged in."
        redirect to '/'
      end
    end

  end
end
