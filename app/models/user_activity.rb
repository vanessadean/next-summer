require_relative "../../config/environment.rb"

class UserActivity < ActiveRecord::Base
  belongs_to :activity
  belongs_to :user

end
