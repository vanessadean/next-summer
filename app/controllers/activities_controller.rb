require_relative "app"

class ActivitiesController < App
  get '/activities' do
    @interests = Tag.all.sort_by { |tag| tag.name }
    erb :activities
  end

  post '/activities' do
    @activity = Activity.find(params[:activity_id])
    @user = User.find(params[:current_user_id])
    UserActivity.create(user_id: @user.id, activity_id: @activity.id, done: params[:done])
    redirect "/users/#{@user.id}"
  end

  post '/activities/new' do
    @activity = Activity.new(description: params[:description])
    @activity.link = params[:link]
    @activity.add_existing_tags(params[:tags])
    @activity.add_new_tags(params[:new_tags])
    @activity.save
    @user = User.find(params[:user_id])
    UserActivity.create(user_id: @user.id, activity_id: @activity.id, done: params[:done])
    redirect "/users/#{@user.id}"
  end

  post '/activities/remove' do
    @user = User.find(params[:current_user_id])
    @user_activity = UserActivity.find(params[:user_activity_id])
    @user_activity.destroy
    redirect "/users/#{@user.id}"
  end

  post '/activities/done' do
    @user = User.find(params[:current_user_id])
    @user_activity = UserActivity.find(params[:user_activity_id])
    @user_activity.done = true
    @user_activity.save
    redirect "/users/#{@user.id}"
  end

  post '/delete' do
    @activity = Activity.find(params[:activity_id])
    tags = @activity.tags
    tags.each { |tag| tag.destroy if tag.activities.length == 1 } 
    @activity.destroy
    # tags.each { |tag| tag.destroy if tag.activities.empty? } 
    redirect "/activities"
  end
end