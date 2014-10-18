require_relative "application_controller"

class InterestsController < ApplicationController
  get '/interests' do
    @interests = Tag.all
    erb :interests
  end

  get '/interests/:id' do
    @interest = Tag.find(params[:id])
    @users = @interest.activities.collect { |activity| activity.users }.flatten.uniq
    @interests = Tag.all
    erb :interest
  end
end