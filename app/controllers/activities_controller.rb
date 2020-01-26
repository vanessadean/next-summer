# frozen_string_literal: true

require_relative 'app'

class ActivitiesController < App
  get '/activities' do
    @interests = Tag.all.sort_by(&:name)
    erb :activities
  end

  post '/activities' do
    return unless current_user.present?

    @activity = Activity.find(params[:activity_id])
    @user = current_user
    UserActivity.create(user_id: @user.id, activity_id: @activity.id, done: params[:done])
    redirect "/users/#{@user.id}"
  end

  post '/activities/new' do
    return unless current_user.present?

    @activity = Activity.new(description: params[:description], link: params[:link])
    if @activity.save
      @activity.tags << Tag.where(id: params[:tags])
      @activity.tags.create(name: params[:new_tags])
      @user = current_user
      UserActivity.create(user_id: @user.id, activity_id: @activity.id, done: params[:done])
    end
    redirect "/users/#{@user.id}"
  end

  post '/activities/remove' do
    return unless current_user.present?

    @user = current_user
    @user_activity = UserActivity.find(params[:user_activity_id])
    @user_activity.destroy
    redirect "/users/#{@user.id}"
  end

  post '/activities/done' do
    return unless current_user.present?

    @user = current_user
    @user_activity = UserActivity.find(params[:user_activity_id])
    @user_activity.done = true
    @user_activity.save
    redirect "/users/#{@user.id}"
  end

  post '/delete' do
    return unless current_user.present?

    @activity = Activity.find(params[:activity_id])
    tags = @activity.tags
    tags.each { |tag| tag.destroy if tag.activities.length == 1 }
    @activity.destroy
    redirect '/activities'
  end
end
