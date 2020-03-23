# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Pet.destroy_all
Shelter.destroy_all

shelter_1 = Shelter.create!(name: "Dog-Haven",
                            address:  "1234 Barkers Way",
                            city: "Beagle",
                            state: "MA",
                            zip: "01001")

shelter_2 = Shelter.create!(name: "Little King Trashmouth's Animal Rescue",
                            address: "998 Ocean Ave",
                            city: "Ocean Town",
                            state: "NY",
                            zip: "10010")

pet_1 = shelter_1.pets.create!(name: "Charlotte",
                               description: "I like to sleep until it's time to eat.",
                               age: 13,
                               sex: "Female",
                               image: "https://raw.githubusercontent.com/mikez321/adopt_dont_shop_2001/master/app/assets/images/charlotte.jpg")


pet_2 = shelter_1.pets.create!(name: "Sydney",
                               description: "I'm a snuggler and a lover until 3.  Then it's time to hunt!  OWWWWW!",
                               age: 13,
                               sex: "Female",
                               image: "https://raw.githubusercontent.com/mikez321/adopt_dont_shop_2001/master/app/assets/images/sydney.jpg")

pet_3 = shelter_2.pets.create!(name: "Huckleberry",
                               description: "I love adventure and haircuts!",
                               age: 8,
                               sex: "Male",
                               image: "https://raw.githubusercontent.com/mikez321/adopt_dont_shop_2001/master/app/assets/images/hb.jpg")
