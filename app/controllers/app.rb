# frozen_string_literal: true

require_relative '../../config/environment'

class App < Sinatra::Application
  helpers do
    def signed_in
      !session[:uid].nil?
    end

    def current_user
      @current_user ||= User.find_by(twitter: session[:twitter_handle], uid: session[:uid])
    end
  end

  before do
    pass if request.path_info =~ /^\/auth\/|^\/$|^\/activities|^\/interests/

    # /auth/twitter is captured by omniauth:
    # when the path info matches /auth/twitter, omniauth will redirect to twitter
    redirect to('/auth/twitter') unless signed_in
  end

  get '/' do
    @activities = Activity.order('RANDOM()').limit(8).sort_by(&:description)
    @tags = Tag.order('RANDOM()').limit(8).sort_by(&:name)
    erb :index
  end

  get '/auth/twitter/callback' do
    session[:uid] = env['omniauth.auth']['uid']
    session[:twitter_handle] = env['omniauth.auth']['info']['nickname']
    name = env['omniauth.auth']['info']['name']
    photo_url = env['omniauth.auth']['info']['image'].gsub('normal', '400x400')
    user = User.find_or_create_by(twitter: session[:twitter_handle], name: name)
    user.update(uid: session[:uid], photo_url: photo_url)
    # this is the main endpoint to your application
    redirect to('/')
  end

  get '/auth/failure' do
    # omniauth redirects to /auth/failure when it encounters a problem
    redirect to('/')
  end

  get '/sign-out' do
    session[:uid] = nil
    redirect to('/')
  end
end
