require 'sinatra/activerecord'
require 'omniauth-twitter'
require 'bundler'
Bundler.require

Dotenv.load

Dir['./app/models/*.rb'].each { |file| require file }

configure do
  set :root, File.dirname(__FILE__)
  set :public_folder, 'public'
  set :views, 'app/views'

  use Rack::Session::Cookie, key: 'rack.session',
                             expire_after: 86400, # In seconds (this is 1 day)
                             secret: ENV['SECRET']

  use OmniAuth::Builder do
    provider :twitter, ENV['API_KEY'], ENV['API_SECRET_KEY']
  end

  db = URI.parse(ENV['DATABASE_URL'] || 'postgres://localhost/postgres')

  ActiveRecord::Base.establish_connection(
    adapter: db.scheme == 'postgres' ? 'postgresql' : db.scheme,
    host: db.host,
    username: db.user,
    password: db.password,
    database: db.path[1..-1],
    encoding: 'utf8'
  )
end
