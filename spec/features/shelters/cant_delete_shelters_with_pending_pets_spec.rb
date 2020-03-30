require 'rails_helper'

RSpec.describe "If a shelter has pets with a status of pending they can not be deleted", type: :feature do
    it "because there is no delete button for them when they have pending pets" do

    shelter_1 = Shelter.create(
      name: "Dog-Haven",
      address:  "1234 Barkers Way",
      city: "Beagle",
      state: "MA",
      zip: "01001"
    )

    shelter_2 = Shelter.create(
      name: "The Cat Palace",
      address: "998 Kings Ct",
      city: "Kings Landing",
      state: "CA",
      zip: "90210"
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

    visit "/shelters"

    within "#shelter-#{shelter_1.id}" do
      expect(page).to have_content("Delete Shelter")
    end

    within "#shelter-#{shelter_2.id}" do
      expect(page).to have_content("Delete Shelter")
    end

    visit "/pets/#{pet_1.id}"

    within "section" do
      click_link "Favorite Pet"
    end


    visit("/favorites")

    click_link "Adopt Favorite Pets"

    expect(current_path).to eq("/pet_applications/new")

    within("#pet-#{pet_1.id}") do
      check "#{pet_1.name}"
    end

    fill_in :name, with: "Jesse"
    fill_in :address, with: "12345 Jesse Ave"
    fill_in :city, with: "Jesse"
    fill_in :state, with: "CO"
    fill_in :zip, with: "80120"
    fill_in :phone_number, with: "303-867-5309"
    fill_in :description, with: "Because I'm too cool for school"

    click_button "Submit Application"

    expect(page).to have_content("Your application was submitted successfully!")

    visit("/shelters")

    within "#shelter-#{shelter_1.id}" do
      expect(page).to_not have_link("Delete Shelter")
    end

    within "#shelter-#{shelter_2.id}" do
      expect(page).to have_link("Delete Shelter")
    end

    visit("/shelters/#{shelter_1.id}")

    expect(page).to_not have_content("Delete Shelter")

    visit("/shelters/#{shelter_2.id}")

    expect(page).to have_content("Delete Shelter")

  end
end
