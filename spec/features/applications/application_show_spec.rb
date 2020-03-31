require 'rails_helper'

RSpec.describe "when i visit an application show page i can see pets applied for" do
  it "and i can see name, address, city, state, zip, phone number, and description" do

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

    visit "/pets/#{pet_1.id}"

    within "section" do
      click_link "Favorite Pet"
    end

    visit "/pets/#{pet_2.id}"

    within "section" do
      click_link "Favorite Pet"
    end

    visit "/pets/#{pet_3.id}"

    within "section" do
      click_link "Favorite Pet"
    end

    visit("/favorites")

    click_link "Adopt Favorite Pets"

    expect(current_path).to eq("/pet_applications/new")

    within("#pet-#{pet_1.id}") do
      check "#{pet_1.name}"
    end

    within("#pet-#{pet_2.id}") do
      check "#{pet_2.name}"
    end

    fill_in :name, with: "Jesse"
    fill_in :address, with: "12345 Jesse Ave"
    fill_in :city, with: "Jesse"
    fill_in :state, with: "CO"
    fill_in :zip, with: "80120"
    fill_in :phone_number, with: "303-867-5309"
    fill_in :description, with: "Because I'm too cool for school"

    click_button "Submit Application"

    visit "/pet_applications/#{PetApplication.last.id}"

    expect(page).to have_content("12345 Jesse Ave")
    expect(page).to have_content("Jesse, CO 80120")
    expect(page).to have_content("303-867-5309")
    expect(page).to have_content("Because I'm too cool for school")

    within "#app-#{PetApplication.last.id}-pet-#{pet_1.id}" do
      expect(page).to have_link("#{pet_1.name}", href:"/pets/#{pet_1.id}")
    end

    within "#app-#{PetApplication.last.id}-pet-#{pet_2.id}" do
      expect(page).to have_link("#{pet_2.name}", href:"/pets/#{pet_2.id}")
    end

  end
end