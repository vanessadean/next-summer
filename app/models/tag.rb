require_relative "../../config/environment.rb"

class Tag < ActiveRecord::Base
  has_many :activity_tags
  has_many :activities, :through => :activity_tags

end
