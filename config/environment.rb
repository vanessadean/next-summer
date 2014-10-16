require "sinatra/activerecord/rake"
require 'pry'
require 'omniauth-twitter'
require 'bundler'
Bundler.require

require_relative "../app/models/activity.rb"
require_relative "../app/models/activity_tag.rb"
require_relative "../app/models/user.rb"
require_relative "../app/models/user_activity.rb"
require_relative "../app/models/tag.rb"

#database
set :database, "sqlite3:///db/database.db"

#configure
configure do
  set :root, File.dirname(__FILE__)
  set :public_folder, 'public'
  set :views, 'app/views'
  
  enable :sessions

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