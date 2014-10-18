require "./app/controllers/app"
require "sinatra/activerecord/rake"

task :seed do 
  taylor = User.create(name: "Taylor", twitter: "taylorswift13", photo_url: "https://pbs.twimg.com/profile_images/505200807503867904/osJXmYRl_400x400.jpeg")
  bob = User.create(name: "Bob", twitter: "bobbertson", photo_url: "https://pbs.twimg.com/profile_images/1152568778/123.png")
  lorde = User.create(name: "Ella", twitter: "lordemusic", photo_url: "https://pbs.twimg.com/profile_images/511931852446523392/hE92_vji_400x400.jpeg")

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

  taylor_activity_1 = UserActivity.create(activity_id: 1, user_id: 1, done: true)
  taylor_activity_2 = UserActivity.create(activity_id: 2, user_id: 1, done: false)
  bob_activity_1 = UserActivity.create(activity_id: 1, user_id: 2, done: true)
  bob_activity_2 = UserActivity.create(activity_id: 4, user_id: 2, done: true)
  bob_activity_3 = UserActivity.create(activity_id: 3, user_id: 2, done: false)
  lorde_activity_1 = UserActivity.create(activity_id: 1, user_id: 3, done: true)
  lorde_activity_2 = UserActivity.create(activity_id: 3, user_id: 3, done: true)
  lorde_activity_3 = UserActivity.create(activity_id: 2, user_id: 3, done: false)
end


