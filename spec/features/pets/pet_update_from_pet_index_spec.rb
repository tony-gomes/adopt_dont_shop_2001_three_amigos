require 'rails_helper'

RSpec.describe "when I visit the pets index page or a shelter pets index page", type: :feature do
  describe "next to each pet there is an 'Edit Pet' link" do
    it "when I click the link I am taken to the pet's edit page" do
      shelter_1 = Shelter.create(name: "Dog-Haven",
                                 address:  "1234 Barkers Way",
                                 city: "Beagle",
                                 state: "MA",
                                 zip: "01001")

      pet_1 = shelter_1.pets.create!(name: "Charlotte",
                                     age: 13,
                                     sex: "Female",
                                     image: "https://raw.githubusercontent.com/mikez321/adopt_dont_shop_2001/master/app/assets/images/charlotte.jpg")

      visit "/pets/"
        expect(page).to have_content("Edit Pet")

      click_link "Edit Pet"
        expect(current_path).to eq("/pets/#{pet_1.id}/edit")

      click_link "Shelters Index"
        expect(current_path).to eq("/")

      click_link "Dog-Haven"
        expect(current_path).to eq("/shelters/#{shelter_1.id}")

      click_link "See Our Pets"
        expect(current_path).to eq("/shelters/#{shelter_1.id}/pets")

      click_link "Edit Pet"
        expect(current_path).to eq("/pets/#{pet_1.id}/edit")


    end
  end
end
