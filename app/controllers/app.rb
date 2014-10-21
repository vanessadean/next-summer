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
    redirect to('/')
  end

  get '/sign-out' do
    session[:uid] = nil
    redirect to('/')
  end
end