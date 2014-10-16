require_relative "../../config/environment.rb"

class ActivityTag < ActiveRecord::Base
  belongs_to :tag
  belongs_to :activity

end
