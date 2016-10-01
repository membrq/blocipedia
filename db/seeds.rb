require 'faker'

10.times do
  User.create!(
  name: Faker::Internet.user_name,
  email: Faker::Internet.email,
  password: Faker::Internet.password(8)
  )
end
users = User.all

50.times do
  Wiki.create!(
  user: users.sample,
  title: Faker::Yoda.quote,
  body: Faker::StarWars.quote
  )
end
items = Wiki.all

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} items created"
