require_relative "../config/environment.rb"

class Activity < ActiveRecord::Base
  has_many :activity_tags
  has_many :tags, :through => :activity_tags
  has_many :user_activities
  has_many :users, :through => :user_activities

  def add_existing_tags(tags)
    tags.each do |key, value|
      self.tags << Tag.find(value)
    end
  end

  def add_new_tags(tags)
    new_tags = tags.split(",")
    new_tags.each do |new_tag|
      self.tags << Tag.create(name: new_tag)
    end   
  end
end
