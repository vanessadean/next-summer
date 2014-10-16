require 'bundler'
Bundler.require
require_relative "../../config/environment.rb"

class SessionsController < Sinatra::Application
  get '/auth/twitter/callback' do
    session[:uid] = env['omniauth.auth']['uid']
    @twitter_handle = env['omniauth.auth']['info']['nickname']
    @name = env['omniauth.auth']['info']['name']
    @user = User.find_or_create_by(twitter: @twitter_handle, name: @name)
    @user.uid = env['omniauth.auth']['uid']
    @user.save
    # this is the main endpoint to your application
    redirect to('/')
  end

  get '/auth/failure' do
    # omniauth redirects to /auth/failure when it encounters a problem
    # so you can implement this as you please
    erb :join
  end

  get '/sign-out' do
    session[:uid] = nil
    redirect to('/')
  end

  # post '/sign-up' do
  #   session[:uid] = params[:uid]
  #   @user = User.create(name: params[:name], email: params[:email], uid: params[:uid])
  #   redirect to('/')
  # end

  # post '/sign-in' do
  #   @user = User.find_by(email: params[:user_email])
  #   session[:uid] = @user.uid
  #   redirect to('/')
  # end
end