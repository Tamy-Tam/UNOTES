# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)





FavouriteNote.destroy_all
Note.destroy_all
Ycourse.destroy_all
User.destroy_all


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


puts 'Creating 6 fake notes...'
6.times do
  ycourse_one = Ycourse.last
  notes = Note.new(
    title: "Notes sur  #{Faker::Company.name}",
    # content: "#{Faker::Computer.stack} #{Faker::Computer.stack} #{Faker::Computer.stack} #{Faker::Computer.stack} #{Faker::Computer.stack}
    #{Faker::Computer.stack} #{Faker::Computer.stack} #{Faker::Computer.stack} #{Faker::Computer.stack} #{Faker::Computer.stack}
    #{Faker::Computer.stack} #{Faker::Computer.stack} #{Faker::Computer.stack}",
    visible: true,
    user_id: user1.id,
    ycourse_id: ycourse_one.id
  )
  notes.save!
end
puts 'notes created!'


puts 'Creating 5 fake favourite notes...'
5.times do
  note_one = Note.last
  fav_note = FavouriteNote.new(
    user_id: user1.id,
    note_id: note_one .id
  )
  fav_note.save!
end
puts 'favourite notes created!'

puts 'Finished!'

