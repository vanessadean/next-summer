require 'bundler'
Bundler.require
require_relative "config/environment.rb"

class App < Sinatra::Application
  #configure
  configure do
    set :root, File.dirname(__FILE__)
    set :public_folder, 'public'
  end

  #database
  set :database, "sqlite3:///database.db"

  get '/' do
    @users = User.all.sample(5).sort_by { |user| user.name }
    @tags = Tag.all.sample(10).sort_by { |tag| tag.name }
    erb :index
  end

  get '/users' do
    @users = User.all
    erb :users
  end

  get '/users/:id' do
    @user = User.find(params[:id])
    @activities_done = @user.user_activities.where(done: true)
    @activities_todo = @user.user_activities.where(done: false)
    erb :user
  end

  get '/activities' do
    @activities = Activity.all
    erb :activities
  end

  get '/interests' do
    @interests = Tag.all
    erb :interests
  end

  get '/interests/:id' do
    @interest = Tag.find(params[:id])
    erb :interest
  end
end
