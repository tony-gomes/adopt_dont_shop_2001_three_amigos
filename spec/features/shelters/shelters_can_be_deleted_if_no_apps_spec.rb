require 'rails_helper'

RSpec.describe "If a shelter has no pets with approved applicaitons", type: :feature do
  it "That shelter can be deleted and all pets in that shelter will also be deleted" do

    shelter_1 = Shelter.create(name: "Dog-Haven",
                               address:  "1234 Barkers Way",
                               city: "Beagle",
                               state: "MA",
                               zip: "01001")

    pet_1 = shelter_1.pets.create!(name: "Charlotte",
                                   age: 13,
                                   description: "I sleep 'till it's time to eat!",
                                   sex: "Female",
                                   image: "https://raw.githubusercontent.com/mikez321/adopt_dont_shop_2001/master/app/assets/images/charlotte.jpg")

    pet_2 = shelter_1.pets.create!(name: "Sydney",
                                   age: 13,
                                   description: "I like to roll in the grass.",
                                   sex: "Female",
                                   image: "https://raw.githubusercontent.com/mikez321/adopt_dont_shop_2001/master/app/assets/images/sydney.jpg")

    visit "/pets"

    expect(page).to have_content "#{pet_1.name}"
    expect(page).to have_content "#{pet_2.name}"

    visit "/shelters"

    expect(page).to have_content "#{shelter_1.name}"

    expect(page).to have_link "Delete Shelter"

    click_link "Delete Shelter"

    expect(page).to_not have_link "Delete Shelter"

    visit "/pets"

    expect(page).to_not have_content "#{pet_1.name}"
    expect(page).to_not have_content "#{pet_2.name}"


  end
end
