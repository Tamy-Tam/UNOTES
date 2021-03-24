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
    text_content: "{\"time\":1616512069550,\"blocks\":[{\"type\":\"header\",\"data\":{\"text\":\"Editor.js\",\"level\":2}},{\"type\":\"paragraph\",\"data\":{\"text\":\"Hey. Meet the new Editor. On this page you can see it in action — try to edit this text. Source code of the page contains the example of connection and configuration.\"}},{\"type\":\"header\",\"data\":{\"text\":\"Key features\",\"level\":3}},{\"type\":\"list\",\"data\":{\"style\":\"unordered\",\"items\":[\"It is a block-styled editor\",\"It returns clean data output in JSON\",\"Designed to be extendable and pluggable with a simple API\"]}},{\"type\":\"header\",\"data\":{\"text\":\"What does it mean «block-styled editor»\",\"level\":3}},{\"type\":\"paragraph\",\"data\":{\"text\":\"Workspace in classic editors is made of a single contenteditable element, used to create different HTML markups. Editor.js workspace consists of separate Blocks: paragraphs, headings, images, lists, quotes, etc. Each of them is an independent contenteditable element (or more complex structure) provided by Plugin and united by Editor's Core.\"}},{\"type\":\"paragraph\",\"data\":{\"text\":\"There are dozens of <a href=\\\"https://github.com/editor-js\\\">ready-to-use Blocks</a> and the <a href=\\\"https://editorjs.io/creating-a-block-tool\\\">simple API</a> for creation any Block you need. For example, you can implement Blocks for Tweets, Instagram posts, surveys and polls, CTA-buttons and even games.\"}},{\"type\":\"header\",\"data\":{\"text\":\"What does it mean clean data output\",\"level\":3}},{\"type\":\"paragraph\",\"data\":{\"text\":\"Classic WYSIWYG-editors produce raw HTML-markup with both content data and content appearance. On the contrary, Editor.js outputs JSON object with data of each Block. You can see an example below\"}},{\"type\":\"paragraph\",\"data\":{\"text\":\"Given data can be used as you want: render with HTML for Web clients, render natively for mobile apps, create markup for Facebook Instant Articles or Google AMP, generate an audio version and so on.\"}},{\"type\":\"paragraph\",\"data\":{\"text\":\"Clean data is useful to sanitize, validate and process on the backend.\"}},{\"type\":\"paragraph\",\"data\":{\"text\":\"We have been working on this project more than three years. Several large media projects help us to test and debug the Editor, to make its core more stable. At the same time we significantly improved the API. Now, it can be used to create any plugin for any task. Hope you enjoy. 😏\"}}],\"version\":\"2.19.3\"}",
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

