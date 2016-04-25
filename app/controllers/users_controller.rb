class UsersController < ApplicationController

  get '/' do
    if logged_in?
      flash[:success] = "Welcome back."
      redirect to '/home'
    else
      erb :'/users/authorization'
    end
  end

  get '/home' do
    redirect_if_logged_out
    @tasks = current_user.tasks
    erb :'/users/home'
  end

  get '/logout' do
    redirect_if_logged_out
    logout!
    flash[:success] = "Logged out."
    redirect to '/'
  end

  post '/login' do
    redirect_if_logged_in
    log_in(params)
  end

  post '/signup' do
    redirect_if_logged_in
    sign_up(params)
  end

end
