class UsersController < ApplicationController

  get '/login' do
    if logged_in?
      redirect to '/home'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    if logged_in?
      redirect to '/home'
    else
      user = User.find_by(username: params[:username])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect to '/home'
      else
        erb :'/users/login', locals: {message: "Username and/or password is incorrect."}
      end
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect to '/login'
    else
      redirect to '/signup'
    end
  end

  get '/signup' do
    if logged_in?
      redirect to '/home'
    else
      erb :'/users/signup'
    end
  end

  post '/signup' do
    if logged_in?
      redirect to '/home'
    else
      user = User.new(params)
      if user.save
        session[:user_id] = user.id
        redirect to '/home'
      elsif (params[:username] == "" || params[:password] == "")
        erb :'/users/signup', locals: {message: "Please enter an username and password."}
      else
        erb :'/users/signup', locals: {message: "Username is taken."}
      end
    end
  end

end
