require_relative "app"

class InterestsController < App
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