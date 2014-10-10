require "./app"
require "sinatra/activerecord/rake"

task :seed do 
  vanessa = User.create(name: "Vanessa", twitter: "vanessadeano")
  bob = User.create(name: "Bob", twitter: "bobbertson")
  kesha = User.create(name: "Kesha", twitter: "ke$ha")

  activity_1 = Activity.create(description: "Flatiron Summer Camp", link: "http://after.flatironschool.com")
  activity_2 = Activity.create(description: "Google Internship", link: "http://www.google.com")
  activity_3 = Activity.create(description: "Rutgers Orchestra Camp", link: "http://www.masongross.rutgers.edu/content/rutgers-summer-band-and-orchestra-camp")
  activity_4 = Activity.create(description: "Gotham Tennis Academy", link: "http://www.gothamtennis.com/summercamp.html")

  tag_1 = Tag.create(name: "Technology")
  tag_2 = Tag.create(name: "Internship")
  tag_3 = Tag.create(name: "Music")
  tag_4 = Tag.create(name: "Sports")
  tag_5 = Tag.create(name: "Coding")

  activity_1.tags << [tag_1, tag_5]
  activity_1.save
  activity_2.tags = [tag_1, tag_2]
  activity_2.save
  activity_3.tags << tag_3 
  activity_3.save
  activity_4.tags << tag_4
  activity_4.save

  vanessa_activity_1 = UserActivity.create(activity_id: 1, user_id: 1, done: true)
  vanessa_activity_2 = UserActivity.create(activity_id: 2, user_id: 1, done: false)
  bob_activity_1 = UserActivity.create(activity_id: 1, user_id: 2, done: true)
  bob_activity_2 = UserActivity.create(activity_id: 4, user_id: 2, done: true)
  bob_activity_3 = UserActivity.create(activity_id: 3, user_id: 2, done: false)
  kesha_activity_1 = UserActivity.create(activity_id: 1, user_id: 3, done: true)
  kesha_activity_2 = UserActivity.create(activity_id: 3, user_id: 3, done: true)
  kesha_activity_3 = UserActivity.create(activity_id: 2, user_id: 3, done: false)
end


