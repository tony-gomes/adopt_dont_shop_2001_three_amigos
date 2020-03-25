# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Pet.destroy_all
Shelter.destroy_all

# Shelters
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

# Pets

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

# Shelter Reviews

review_1 = shelter_1.reviews.create!(review_image: "https://via.placeholder.com/150",
                                   title: "test review 1",
                                   rating: 1,
                                   content: "Donec at purus porttitor nibh hendrerit vulputate vitae et arcu. Aenean viverra faucibus lectus, eget consectetur mi lobortis in. Aliquam consectetur justo vel justo dignissim pretium.")

review_2 = shelter_1.reviews.create!(review_image: "https://via.placeholder.com/150",
                                   title: "test review 2",
                                   rating: 4,
                                   content: "Nulla sit amet laoreet ligula. Suspendisse pretium tincidunt nibh eu molestie. Quisque at diam lorem. Ut mattis sem eget rhoncus finibus.")

review_3 = shelter_1.reviews.create!(review_image: "https://via.placeholder.com/150",
                                   title: "test review 3",
                                   rating: 3,
                                   content: "Nulla id magna id velit rutrum imperdiet eu id dolor. Fusce fermentum est eget dictum blandit.")

review_4 = shelter_2.reviews.create!(review_image: "https://via.placeholder.com/149",
                                   title: "test review 4",
                                   rating: 4,
                                   content: "In sit amet turpis iaculis, vulputate purus vel, malesuada nisi. Nam molestie pellentesque lorem. Aliquam elementum aliquet tempus.")

review_5 = shelter_2.reviews.create!(review_image: "https://via.placeholder.com/149",
                                   title: "test review 5",
                                   rating: 4,
                                   content: "In hac habitasse platea dictumst. Ut eu lectus et nisl volutpat pellentesque. Proin bibendum cursus efficitur.")
