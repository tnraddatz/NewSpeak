# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
## User.delete_all
#  ActiveRecord::Base.connection.reset_pk_sequence!('users')
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Users
User.create!(email: "thomas@cox.net",
             password:              "password",
             password_confirmation: "password")

Outlet.create!(outlet_name: "GitHub", siteurl: "www.github.com",
               imageurl: "https://besticon-demo.herokuapp.com/icon?url=www.github.com&size=70..120..200",
               total_records: 0)

Outlet.create!(outlet_name: "Yelp", siteurl: "www.yelp.com",
              imageurl: "https://besticon-demo.herokuapp.com/icon?url=www.yelp.com&size=70..120..200",
              total_records: 0)

2.times do |n|
  email = "example-#{n+1}@cox.net"
  password = "password"
  User.create!(
               email: email,
               password:              password,
               password_confirmation: password)
end

# Following relationships

outlets = Outlet.all
user  = User.first
#following = users[2..50]
#followers = users[3..40]
outlets.each { |outlet| user.follow(outlet) }
