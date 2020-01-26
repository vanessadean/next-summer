# frozen_string_literal: true

require_relative '../../config/environment.rb'

class Activity < ActiveRecord::Base
  has_many :activity_tags, dependent: :destroy
  has_many :tags, through: :activity_tags
  has_many :user_activities, dependent: :destroy
  has_many :users, through: :user_activities
end
