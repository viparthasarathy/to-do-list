class UsersController < ApplicationController

  get '/login' do
    erb :'/users/login'
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to '/home'
    else
      erb :'/users/login', locals: {message: "Username and/or password is incorrect."}
    end
  end

  get '/signup' do
    erb :'/users/login'
  end

  post '/signup' do
  end

end
