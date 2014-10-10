require "sinatra/activerecord/rake"
require 'pry'

require_relative "../lib/activity.rb"
require_relative "../lib/activity_tag.rb"
require_relative "../lib/user.rb"
require_relative "../lib/user_activity.rb"
require_relative "../lib/tag.rb"

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