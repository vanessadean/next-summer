require 'bundler'
Bundler.require
require_relative "../../config/environment.rb"

class InterestsController < Sinatra::Application
  get '/interests' do
    @interests = Tag.all
    erb :interests
  end

  get '/interests/:id' do
    @interest = Tag.find(params[:id])
    erb :interest
  end
end