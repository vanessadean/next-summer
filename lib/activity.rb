require_relative "../config/environment.rb"

class Activity < ActiveRecord::Base
  has_many :activity_tags
  has_many :tags, :through => :activity_tags
  has_many :user_activities
  has_many :users, :through => :user_activities

end
