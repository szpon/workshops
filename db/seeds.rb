# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user_list = [
  [ "admin@workshop.com", "admin123", true ],
  [ "user1@workshop.com", "password1", false ],
  [ "user2@workshop.com", "password2", false ],
  [ "user3@workshop.com", "password3", false ],
  [ "user4@workshop.com", "password4", false ],
  [ "user5@workshop.com", "password5", false ]
]

user_list.each do |email, password, admin|
  User.create!( 
    email: email,
    password: password,
    firstname: Faker::Name.name.split(" ").first,
    lastname: Faker::Name.name.split(" ").last,
    admin: admin
  )
end

Category.create!(name: "Example category")

5.times do |i|
  User.first.products.create!(
    title: "Product ##{i+1}",
    description: "Unusual product.",
    price: rand(1..1000),
    category_id: 1
  )
end

10.times do |i|
  User.find(rand(1..6)).reviews.create!(
    content: "Good product",
    rating: rand(1..5),
    product_id: rand(1..5)
  )
end
