require_relative "../../config/environment"

class App < Sinatra::Application
  helpers do
    # define a current_user method, so we can be sure if an user is authenticated
    def signed_in
      !session[:uid].nil?
    end

    def current_user
      current_user = User.find_by(uid: session[:uid])
    end
  end

  before do
    # we do not want to redirect to twitter when the path info starts with /auth/ or is the home page '/'
    pass if request.path_info =~ /^\/auth\/|^\/$/

    # /auth/twitter is captured by omniauth:
    # when the path info matches /auth/twitter, omniauth will redirect to twitter
    redirect to('/auth/twitter') unless signed_in
  end

  get '/' do
    @users = User.all.sample(4).sort_by { |user| user.name }
    @tags = Tag.all.sample(8).sort_by { |tag| tag.name }
    erb :index
  end

  get '/auth/twitter/callback' do
    session[:uid] = env['omniauth.auth']['uid']
    @twitter_handle ||= env['omniauth.auth']['info']['nickname']
    @name ||= env['omniauth.auth']['info']['name']
    @photo_url = env['omniauth.auth']['info']['image'].gsub("normal", "400x400")
    @user = User.find_or_create_by(twitter: @twitter_handle, name: @name)
    @user.uid ||= env['omniauth.auth']['uid']
    @user.photo_url ||= @photo_url
    @user.save
    # this is the main endpoint to your application
    redirect to('/')
  end

  get '/auth/failure' do
    # omniauth redirects to /auth/failure when it encounters a problem
    # so you can implement this as you please
    erb :oauth_fail
  end

  get '/sign-out' do
    session[:uid] = nil
    redirect to('/')
  end

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

  get '/activities' do
    @interests = Tag.all.sort_by { |tag| tag.name }
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

  get '/interests' do
    @interests = Tag.all.sort_by { |tag| tag.name }
    erb :interests
  end

  get '/interests/:id' do
    @interest = Tag.find(params[:id])
    @users = @interest.activities.collect { |activity| activity.users }.flatten.uniq
    @interests = Tag.all.sort_by { |tag| tag.name }
    erb :interest
  end
end