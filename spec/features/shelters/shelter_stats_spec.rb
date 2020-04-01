require 'rails_helper'

RSpec.describe "when I visit a shelter's show page", type: :feature do
  it "I see that shelter's count of pets, average review, and number of applicants for that shelter" do

      shelter_1 = Shelter.create(name: "Dog-Haven",
                                 address:  "1234 Barkers Way",
                                 city: "Beagle",
                                 state: "MA",
                                 zip: "01001")

      shelter_2 = Shelter.create(name: "The Cat Palace",
                                 address: "998 Kings Ct",
                                 city: "Kings Landing",
                                 state: "CA",
                                 zip: "90210")

      review_1 = shelter_1.reviews.create!(review_image: "https://via.placeholder.com/150",
                                          title: "test review 1",
                                          rating: 2,
                                          content: "this review is average at best.")

      review_2 = shelter_1.reviews.create!(review_image: "https://via.placeholder.com/150",
                                          title: "test review 2",
                                          rating: 2,
                                          content: "this review is average at best.")

      review_3 = shelter_1.reviews.create!(review_image: "https://via.placeholder.com/150",
                                          title: "test review 3",
                                          rating: 3,
                                          content: "this review is average at best.")

      review_4 = shelter_2.reviews.create!(review_image: "https://via.placeholder.com/149",
                                          title: "test review 4",
                                          rating: 5,
                                          content: "this review is missing at best.")

      pet_1 = shelter_1.pets.create!(name: "Charlotte",
                                     age: 13,
                                     sex: "Female",
                                     image: "https://raw.githubusercontent.com/mikez321/adopt_dont_shop_2001/master/app/assets/images/charlotte.jpg")

      pet_2 = shelter_1.pets.create!(name: "Sydney",
                                     age: 13,
                                     sex: "Female",
                                     image: "https://raw.githubusercontent.com/mikez321/adopt_dont_shop_2001/master/app/assets/images/sydney.jpg")

      pet_3 = shelter_2.pets.create!(name: "Huckleberry",
                                     description: "I love adventure and haircuts!",
                                     age: 8,
                                     sex: "Male",
                                     image: "https://raw.githubusercontent.com/mikez321/adopt_dont_shop_2001/master/app/assets/images/hb.jpg")

      visit("/shelters/#{shelter_1.id}")

      expect(page).to have_content("Pets at this location: 2")
      expect(page).to have_content("Average rating: 2.3")
      
      visit("/shelters/#{shelter_2.id}")

      expect(page).to have_content("Pets at this location: 1")
      expect(page).to have_content("Average rating: 5")
  end
end
