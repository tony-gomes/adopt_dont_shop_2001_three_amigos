require 'rails_helper'

RSpec.describe "when i visit any page", type: :feature do
  it "there is a link to the shelter index" do

    shelter_1 = Shelter.create(name: "Dog-Haven",
                               address:  "1234 Barkers Way",
                               city: "Beagle",
                               state: "MA",
                               zip: "01001")

    pet_1 = shelter_1.pets.create!(name: "Charlotte",
                                   age: 13,
                                   sex: "Female",
                                   image: "https://raw.githubusercontent.com/mikez321/adopt_dont_shop_2001/master/app/assets/images/charlotte.jpg")


    visit "/"
      expect(page).to have_content("Shelters Index")
        click_link "Shelters Index"
          expect(current_path).to eq "/"

    visit "/shelters/#{shelter_1.id}"
      expect(page).to have_content("Shelters Index")
        click_link "Shelters Index"
          expect(current_path).to eq "/"

    visit "/shelters/#{shelter_1.id}/pets"
      expect(page).to have_content("Shelters Index")
        click_link "Shelters Index"
          expect(current_path).to eq "/"

    visit "/pets"
      expect(page).to have_content("Shelters Index")
        click_link "Shelters Index"
          expect(current_path).to eq "/"

    visit "/pets/#{pet_1.id}"
      expect(page).to have_content("Shelters Index")
        click_link "Shelters Index"
          expect(current_path).to eq "/"

  end
end
