require 'rails_helper'

RSpec.describe "when i click on the name of a shleter", type: :feature do
  it "brings me to the shelters show page" do
    shelter_1 = Shelter.create(name: "Dog-Haven",
                               address:  "1234 Barkers Way",
                               city: "Beagle",
                               state: "MA",
                               zip: "01001")

    pet_1 = shelter_1.pets.create!(name: "Charlotte",
                                   age: 13,
                                   sex: "Female",
                                   image: "https://raw.githubusercontent.com/mikez321/adopt_dont_shop_2001/master/app/assets/images/charlotte.jpg")


    visit "/pets"
      expect(page).to have_content(shelter_1.name)

    click_link "#{shelter_1.name}"
      expect(current_path).to eq("/shelters/#{shelter_1.id}")

    click_link "Shelters Index"
      click_link "#{shelter_1.name}"
        expect(current_path).to eq("/shelters/#{shelter_1.id}")

  end
end
