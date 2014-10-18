require "sinatra/activerecord/rake"
require 'pry'
require 'omniauth-twitter'
require 'bundler'
Bundler.require

Dir['./app/models/*.rb'].each { |file| require file }

#database
set :database, "sqlite3:///db/database.db"

#configure
configure do
  set :root, File.dirname(__FILE__)
  set :public_folder, 'public'
  set :views, 'app/views'
  
  use Rack::Session::Cookie, :key => 'rack.session',
                             :expire_after => 2592000, # In seconds (this is 30 days)
                             :secret => 'fomo'

  use OmniAuth::Builder do
    provider :twitter, 'NueTDLknNPKoaxcGMelzPwfbN', 'KqC9R0pQqYEzvIZW269qcG6t7MGIyLCE1owNALwKeNssyxiOGN'
  end
end

configure :production do
 db = URI.parse(ENV['DATABASE_URL'] || 'postgres:///localhost/database')

 ActiveRecord::Base.establish_connection(
   :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
   :host     => db.host,
   :username => db.user,
   :password => db.password,
   :database => db.path[1..-1],
   :encoding => 'utf8'
 )
end