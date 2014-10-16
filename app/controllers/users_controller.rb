require 'bundler'
Bundler.require
require_relative "../../config/environment.rb"

class UsersController < Sinatra::Application
  get '/users' do
    @users = User.all
    erb :users
  end

  get '/users/:id' do
    @user = User.find(params[:id])
    @activities_done = @user.user_activities.where(done: true)
    @activities_todo = @user.user_activities.where(done: false)
    @tags = Tag.all
    erb :user
  end
end