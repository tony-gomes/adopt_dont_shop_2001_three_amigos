require 'rails_helper'

RSpec.describe "when I have favorited pets and i visit my favorites index page", type: :feature do
  it "I see all the pets I've favorited" do

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

    visit "/pets/#{pet_1.id}"

    within "section" do
      click_link "Favorite Pet"
    end

    visit "/favorite"

    expect(page).to have_content("#{pet_1.name}")
    expect(page).to have_css("img[src*='#{pet_1.image}']")

  end
end
