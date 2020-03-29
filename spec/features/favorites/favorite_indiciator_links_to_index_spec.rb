require 'rails_helper'

RSpec.describe "when I click on the favorite indicator on the nav bar", type: :feature do
  it "I am taken to the favorite index page" do

    shelter_1 = Shelter.create!(
      name: "Dog-Haven",
      address:  "1234 Barkers Way",
      city: "Beagle",
      state: "MA",
      zip: "01001"
    )

    pet_1 = shelter_1.pets.create!(
      name: "Charlotte",
      description: "I will do anything for a treat!",
      age: 13,
      sex: "Female",
      image: "https://raw.githubusercontent.com/mikez321/adopt_dont_shop_2001/master/app/assets/images/charlotte.jpg"
    )

    pet_2 = shelter_1.pets.create!(
      name: "Sydney",
      age: 13,
      sex: "Female",
      image: "https://raw.githubusercontent.com/mikez321/adopt_dont_shop_2001/master/app/assets/images/sydney.jpg")


    visit "/pets/#{pet_1.id}"

    within "section" do
      click_link "Favorite Pet"
    end

    within "nav" do
      click_link "Favorite Pets: 1"
    end

    expect(current_path).to eq("/favorites")

    expect(page).to have_content("#{pet_1.name}")
    expect(page).to have_css("img[src*='#{pet_1.image}']")


    visit "/pets/#{pet_2.id}"

    within "section" do
      click_link "Favorite Pet"
    end

    within "nav" do
      click_link "Favorite Pets: 2"
    end

    expect(current_path).to eq("/favorites")

    expect(page).to have_content("#{pet_1.name}")
    expect(page).to have_css("img[src*='#{pet_1.image}']")
    expect(page).to have_content("#{pet_2.name}")
    expect(page).to have_css("img[src*='#{pet_2.image}']")

    click_link "#{pet_1.name}"

    expect(current_path).to eq("/pets/#{pet_1.id}")

  end
end
