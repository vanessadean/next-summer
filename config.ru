require './app/controllers/app'
require './app/controllers/activities_controller'
require './app/controllers/users_controller'
require './app/controllers/interests_controller'

use InterestsController
use UsersController
use ActivitiesController
run App