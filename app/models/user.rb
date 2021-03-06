# frozen_string_literal: true

require_relative '../../config/environment.rb'

class User < ActiveRecord::Base
  has_many :user_activities, dependent: :destroy
  has_many :activities, through: :user_activities
end
