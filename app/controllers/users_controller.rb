class UsersController < ApplicationController

  get '/login' do
    if logged_in?
      flash[:error] = "Already logged in."
      redirect to '/home'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    if logged_in?
      flash[:error] = "Already logged in."
      redirect to '/home'
    else
      user = User.find_by(username: params[:username])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        flash[:success] = "Welcome back."
        redirect to '/home'
      else
        flash[:error] = "Incorrect username and/or password."
        redirect to '/login'
      end
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      flash[:success] = "Logged out."
      redirect to '/login'
    else
      flash[:error] = "Already logged out."
      redirect to '/login'
    end
  end

  get '/signup' do
    if logged_in?
      flash[:error] = "Please log out to sign up again."
      redirect to '/home'
    else
      erb :'/users/signup'
    end
  end

  post '/signup' do
    if logged_in?
      flash[:error] = "Cannot sign up if logged in."
      redirect to '/home'
    else
      user = User.new(params)
      if user.save
        session[:user_id] = user.id
        flash[:success] = "Signed up!"
        redirect to '/home'
      elsif (params[:username] == "" || params[:password] == "")
        flash[:error] = "Please enter a username and password."
        redirect to '/signup'
      else
        flash[:error] = "Username is taken."
        redirect to '/signup'
      end
    end
  end

end
