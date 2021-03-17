# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


User.destroy_all if Rails.env.development?
Ycourse.destroy_all if Rails.env.development?
#Reservation.destroy_all if Rails.env.development?

#FAKING USERS
require 'faker'
puts 'Creating 5 fake users...'
5.times do
  users = User.new(
    email: Faker::Internet.email,
    password: "123456",
    first_name: Faker::Name.name,
    last_name: Faker::Artist.name,
    bio: Faker::ChuckNorris.fact,
    github_account: "https://github.com/#{Faker::Artist.name}",
    linkedin_account: "https://www.linkedin.com/in/#{Faker::Artist.name}",
    photo:"account.gif"
  )
  users.save!
end
puts 'users created!'


#FAKING ycourses

puts 'Creating 6 ycourses.'
user1 = User.last
Ycourse1 = Ycourse.new(url: "https://www.youtube.com/embed/mAbQZGrXs-k?list=RDCMUChCDYcBCrb8tuPAO6e0P-Hw",title: "Introduction to Docker")
Ycourse1.save!

Ycourse2 = Ycourse.new(url: "https://www.youtube.com/embed/4CyMMypeTtY?list=RDCMUChCDYcBCrb8tuPAO6e0P-Hw",title: "UX & Product design for beginners")
Ycourse2.save!

Ycourse3 = Ycourse.new(url: "https://www.youtube.com/embed/oUJolR5bX6g",title: "APPRENDRE PYTHON [TUTO PROGRAMMATION COMPLET DÉBUTANT]")
Ycourse3.save!

Ycourse4 = Ycourse.new(url: "https://www.youtube.com/embed/PE8FQ6zihhw",title: "Découverte du CSS (1/31) : Présentation")
Ycourse4.save!

Ycourse5 = Ycourse.new(url: "https://www.youtube.com/embed/J9w-cir5a6U",title: "CREER UN SITE ? HTML/CSS #1 - LES BASES")
Ycourse5.save!

Ycourse6 = Ycourse.new(url: "https://www.youtube.com/embed/0PA69L88HeI&list=PLjwdMgw5TTLV7VsXd9NOeq39soYXORezN",title: "NodeJS (1/6) : Qu'est ce que NodeJS ?")
Ycourse6.save!

puts 'ycourses created!'

 # properties = Property.new(
  #  name:  "Chateau #{Faker::Company.name}",
   # address: Faker::Address.full_address,
    #price: Faker::Number.number(digits: 5),
    #photo: "https://picsum.photos/1400/500",
    #user_id: user1.id
  #)
 #properties.save!
#end
puts 'Finished!'
