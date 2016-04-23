class UsersController < ApplicationController

  get '/login' do
    redirect_if_logged_in
    erb :'/users/login'
  end

  post '/login' do
    redirect_if_logged_in
    log_in(params)
  end

  get '/logout' do
    redirect_if_logged_out
    logout!
    flash[:success] = "Logged out."
    redirect to '/login'
  end

  get '/signup' do
    redirect_if_logged_in
    erb :'/users/signup'
  end

  post '/signup' do
    redirect_if_logged_in
    sign_up(params)
  end

end
