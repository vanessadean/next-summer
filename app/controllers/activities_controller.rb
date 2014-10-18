require_relative "application_controller"

class ActivitiesController < ApplicationController
  get '/activities' do
    @interests = Tag.all
    erb :activities
  end

  post '/activities' do
    @activity = Activity.new(description: params[:description])
    @activity.link = params[:link]
    @activity.add_existing_tags(params[:tags])
    @activity.add_new_tags(params[:new_tags])
    @activity.save
    @user = User.find(params[:user_id])
    UserActivity.create(user_id: @user.id, activity_id: @activity.id, done: params[:done])
    redirect "/users/#{@user.id}"
  end
end