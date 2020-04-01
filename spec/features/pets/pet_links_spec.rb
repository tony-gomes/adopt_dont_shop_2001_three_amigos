require 'rails_helper'

RSpec.describe "when i click on the name of a shelter", type: :feature do
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
      expect(page).to have_content("#{pet_1.name}")

    click_link "#{pet_1.name}"
    expect(current_path).to eq("/pets/#{pet_1.id}")

    visit "/shelters/#{shelter_1.id}/pets"
    expect(page).to have_content("#{pet_1.name}")

    click_link "#{pet_1.name}"
    expect(current_path).to eq("/pets/#{pet_1.id}")
  end
end
