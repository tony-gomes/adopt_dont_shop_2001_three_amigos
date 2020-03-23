require 'rails_helper'

RSpec.describe "when I visit a shelter show page", type: :feature do
  it "I see a link to that shelter's pets page" do

    shelter_1 = Shelter.create(name: "Dog-Haven",
                               address:  "1234 Barkers Way",
                               city: "Beagle",
                               state: "MA",
                               zip: "01001")

    pet_1 = shelter_1.pets.create!(name: "Charlotte",
                                   age: 13,
                                   sex: "Female",
                                   image: "https://raw.githubusercontent.com/mikez321/adopt_dont_shop_2001/master/app/assets/images/charlotte.jpg")
    shelter_2 = Shelter.create(name: "Bork Bork",
                               address:  "9939 Fox St",
                               city: "Lakewood",
                               state: "CO",
                               zip: "80232")

    pet_2 = shelter_2.pets.create!(name: "Sydney",
                                   age: 13,
                                   sex: "Female",
                                   image: "https://raw.githubusercontent.com/mikez321/adopt_dont_shop_2001/master/app/assets/images/sydney.jpg")

    visit "/shelters/#{shelter_1.id}"
      expect(page).to have_content("See Our Pets")
        click_link "See Our Pets"
          expect(current_path).to eq("/shelters/#{shelter_1.id}/pets")

    expect(page).to have_content("#{pet_1.name}")
    expect(page).to have_content("#{pet_1.age}")
    expect(page).to have_content("#{pet_1.sex}")
    expect(page).to have_css("img[src*='#{pet_1.image}']")

    visit "/shelters/#{shelter_2.id}"
      expect(page).to have_content("See Our Pets")
        click_link "See Our Pets"
          expect(current_path).to eq("/shelters/#{shelter_2.id}/pets")

    expect(page).to have_content("#{pet_2.name}")
    expect(page).to have_content("#{pet_2.age}")
    expect(page).to have_content("#{pet_2.sex}")
    expect(page).to have_css("img[src*='#{pet_2.image}']")
  end
end
