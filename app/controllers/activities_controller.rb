require 'bundler'
Bundler.require
require_relative "../../config/environment.rb"

class ActivitiesController < Sinatra::Application
  get '/activities' do
    @activities = Activity.all
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