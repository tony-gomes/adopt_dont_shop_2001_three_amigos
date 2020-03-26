require 'rails_helper'

RSpec.describe "as a visitor", type: :feature do
  it "can see favorite indicator with total pets from any page" do
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

   review_1 = shelter_1.reviews.create!(
     review_image: "https://via.placeholder.com/150",
     title: "test review 1",
     rating: 1,
     content: "this review is average at best."
   )

    visit "/shelters"

    within "nav" do
      expect(page).to have_link("Favorite Pets")
    end

    visit "/shelters/new"

    within "nav" do
      expect(page).to have_link("Favorite Pets")
    end

    visit "/shelters/#{shelter_1.id}"

    within "nav" do
      expect(page).to have_link("Favorite Pets")
    end

    visit "/shelters/#{shelter_1.id}/edit"

    within "nav" do
      expect(page).to have_link("Favorite Pets")
    end

    visit "/shelters/#{shelter_1.id}/pets"

    within "nav" do
      expect(page).to have_link("Favorite Pets")
    end

    visit "/shelters/#{shelter_1.id}/pets/new"

    within "nav" do
      expect(page).to have_link("Favorite Pets")
    end

    visit "/shelters/#{shelter_1.id}/reviews/new"

    within "nav" do
      expect(page).to have_link("Favorite Pets")
    end

    visit "/shelters/#{shelter_1.id}/reviews/#{review_1.id}/edit"

    within "nav" do
      expect(page).to have_link("Favorite Pets")
    end

    visit "/pets"

    within "nav" do
      expect(page).to have_link("Favorite Pets")
    end

    visit "/pets/#{pet_1.id}"

    within "nav" do
      expect(page).to have_link("Favorite Pets")
    end

    visit "/pets/#{pet_1.id}/edit"

    within "nav" do
      expect(page).to have_link("Favorite Pets")
    end

  end
end
