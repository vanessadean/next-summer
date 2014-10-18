require_relative "application_controller"

class UsersController < ApplicationController
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

  post '/users/activities' do
    @activity = Activity.find(params[:activity_id])
    @user = User.find(params[:current_user_id])
    UserActivity.create(user_id: @user.id, activity_id: @activity.id, done: params[:done])
    redirect "/users/#{@user.id}"
  end
end