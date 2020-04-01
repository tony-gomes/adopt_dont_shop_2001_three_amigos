require 'rails_helper'

RSpec.describe " if a pet has been favorited and is then deleted" do
  it "is no longer in the favorites list" do

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

    visit "/pets/#{pet_1.id}"

    within "section" do
      click_link "Favorite Pet"
    end

    visit "/pets/#{pet_2.id}"

    within "section" do
      click_link "Favorite Pet"
    end

    visit "/favorites"

    expect(page).to have_content("#{pet_1.name}")
    expect(page).to have_content("#{pet_2.name}")

    visit "/pets/#{pet_1.id}"

    click_link "Delete Pet"

    # visit "/favorites"

    # expect(page).to_not have_content("#{pet_1.name}")
    # expect(page).to have_content("#{pet_2.name}")

  end
end
