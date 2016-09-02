# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

poll = Poll.create(title: "Approach 1 - Manual Labor", description: "What is your favorite meme")

options = []
options << Option.create(title: "Harambe")
options << Option.create(title: "Spongebob memes")
options << Option.create(title: "Arthur memes")
options << Option.create(title: "Dat Boi")
options << Option.create(title: "Pepe")
options << Option.create(title: "Gene Wilder")
options << Option.create(title: "Vaping in general")
options << Option.create(title: "Wo-oah, we're halfway there/ Wo-oah")
options << Option.create(title: "Bottle flipping")
options << Option.create(title: "I’m Rick Harrison and this is my pawn shop. I work here with my old man and my son, Big Hoss, and in 23 years I’ve learned one thing. You never know what is gonna come through that door.")
options << Option.create(title: "All memes are bad")


options.each do |o|
  poll.options << o
end

poll = Poll.create(title: "Approach 2 - Automatic Labor", description: "Who are you voting for in the presidential election?")

options = []
options << Option.create(title: "Trump")

options.each do |o|
  poll.options << o
end


poll = Poll.create(title: "Approach 3 - Code!", description: "Who is the most influential person of the year?")

options = []
options << Option.create(title: "moot")
options << Option.create(title: "Anwar Ibrahim")
options << Option.create(title: "Rick Warren")
options << Option.create(title: "Baitullah Mehsud")
options << Option.create(title: "Larry Brilliant")
options << Option.create(title: "Eric Holder")
options << Option.create(title: "Carlos Slim")
options << Option.create(title: "Angela Merkel")
options << Option.create(title: "Kobe Bryant")
options << Option.create(title: "Evo Morales")
options << Option.create(title: "Alexander Lebedev")
options << Option.create(title: "Lil' Wayne")
options << Option.create(title: "Sheikh Ahmed bin Zayeh Al Nahyan")
options << Option.create(title: "Odell Barnes")
options << Option.create(title: "Tina Fey")
options << Option.create(title: "Hu Jintao")
options << Option.create(title: "Eric Cantor")
options << Option.create(title: "Gamal Mubarak")
options << Option.create(title: "Ali al-Naimi")
options << Option.create(title: "Muqtada al-Sadr")
options << Option.create(title: "Elizabeth Warren")

options.each do |o|
  # fake votes to scramble the names
  rand(20).times do |i|
    o.votes << Vote.create(ip: "system", created_at: (Time.now.to_f.round(3)*1000).to_i)
  end
  
  poll.options << o
end

