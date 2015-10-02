require 'faker'

 # Create Users
 25.times do
   user = User.new(
     name:     Faker::Name.first_name,
     email:    Faker::Internet.email,
     password: "helloworld",
     description: Faker::Lorem.paragraph,
     location: Faker::Address.country
   )
   user.skip_confirmation!
   user.save!
 end
 users = User.all

 # Create Galleries
 20.times do
   gallery = Gallery.create!(
     user:   users.sample,
     title:  Faker::Lorem.sentence,
     body:   Faker::Lorem.paragraph
   )
 end
 galleries = Gallery.all

 # Create Topics
 25.times do
  topic = Topic.create!(
      user:   users.sample,
      title:  Faker::Lorem.sentence,
      body:   Faker::Lorem.paragraph
  )
 end
 topics = Topic.all

 # Create Location
  10.times do
    location = Location.create!(
        name: "#{Faker::Address.street_address}, #{Faker::Address.zip_code} #{Faker::Address.city} #{Faker::Address.state} ",
        lat: Faker::Address.latitude,
        lng: Faker::Address.longitude
    )
  end
  locations = Location.all

 # Create Events
 20.times do
   event = Event.create!(
      user:   users.sample,
      title: Faker::Lorem.sentence,
      type_event: ["party", "bbq", "competition", "ballad", "other"].sample,
      description: Faker::Lorem.paragraph,
      to_bring: Faker::Lorem.sentence,
      minimum_participants: Faker::Number.between(from = 0, to = 450),
      happen_at: Faker::Date.forward(days = 678),
      duration: Random.rand(1000).to_i,
      privacy: Random.rand(1).to_i,
      location: locations.sample
   )
 end
 events = Event.all

 # Create an admin user
 admin = User.new(
   name:     'Admin User',
   email:    'admin@example.com',
   password: 'helloworld',
   role:     'admin'
 )
 admin.skip_confirmation!
 admin.save!

# Create regular user
 rachel = User.new(
   name:     'Rachel',
   email:    'rachel@example.com',
   password: 'helloworld'
 )
 rachel.skip_confirmation!
 rachel.save!

 event_for_rachel = Event.create!(
      user: rachel,
      title: Faker::Lorem.sentence,
      type_event: ["party", "bbq", "competition", "ballad", "other"].sample,
      description: Faker::Lorem.paragraph,
      to_bring: Faker::Lorem.sentence,
      minimum_participants: Faker::Number.between(from = 0, to = 450),
      maximum_participants: Faker::Number.between(from = 1, to = 450),
      happen_at: (Time::now + 5).to_datetime,
      duration: Random.rand(1000).to_i,
      privacy: Random.rand(1).to_i,
      location: locations.sample
 )
 event_for_rachel.save!

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Gallery.count} galleries created"
puts "#{Topic.count} topics created"
puts "#{Event.count} events created"
puts "#{Location.count} locations created"
