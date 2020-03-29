require 'rails_helper'

RSpec.describe "After a pet has one or more applications on it and I visit /favorites", type: :feature do
  describe "there will be a section with all the pets that have open apps on them" do
    it "each pet's name is a link to that pets show page" do

      shelter_1 = Shelter.create(
        name: "Dog-Haven",
        address:  "1234 Barkers Way",
        city: "Beagle",
        state: "MA",
        zip: "01001"
      )

      pet_1 = shelter_1.pets.create!(
        name: "Charlotte",
        age: 13,
        sex: "Female",
        image: "https://raw.githubusercontent.com/mikez321/adopt_dont_shop_2001/master/app/assets/images/charlotte.jpg"
      )

      pet_2 = shelter_1.pets.create!(
        name: "Sydney",
        age: 13,
        sex: "Female",
        image: "https://raw.githubusercontent.com/mikez321/adopt_dont_shop_2001/master/app/assets/images/sydney.jpg"
      )

      pet_3 = shelter_1.pets.create!(
        name: "Huckleberry",
        description: "I love adventure and haircuts!",
        age: 8,
        sex: "Male",
        image: "https://raw.githubusercontent.com/mikez321/adopt_dont_shop_2001/master/app/assets/images/hb.jpg"
      )

      app_1 = PetApplication.create!(
        name: "Jesse",
        address: "12345 Jesse Ave",
        city: "Jesse",
        state: "CO",
        zip: "80120",
        phone_number: "303-867-5309",
        description: "Because I'm too cool for school"
      )

      ApplicationPet.create(pet_id: "#{pet_1.id}", pet_application_id: "#{app_1.id}")
      ApplicationPet.create(pet_id: "#{pet_2.id}", pet_application_id: "#{app_1.id}")

      require "pry"; binding.pry
    end
  end
end
