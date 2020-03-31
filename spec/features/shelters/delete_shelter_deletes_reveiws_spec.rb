require 'rails_helper'

RSpec.describe "If a shelter has no pets with approved applicaitons", type: :feature do
  it "That shelter can be deleted and all pets in that shelter will also be deleted" do

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

    review_1 = shelter_1.reviews.create!(review_image: "https://via.placeholder.com/150",
                                         title: "test review 1",
                                         rating: 1,
                                         content: "this review is average at best.")

    review_2 = shelter_1.reviews.create!(review_image: "https://via.placeholder.com/150",
                                         title: "test review 2",
                                         rating: 2,
                                         content: "this review is average at best.")

    visit("/shelters")
    expect(page).to have_content("#{shelter_1.name}")
    expect(page).to have_content("#{shelter_2.name}")

    visit "/shelters/#{shelter_1.id}"

    expect(page).to have_content "#{review_1.title}"
    expect(page).to have_content "#{review_1.content}"
    expect(page).to have_content "#{review_2.title}"
    expect(page).to have_content "#{review_2.content}"

    expect(page).to have_link ("Delete Shelter")

    expect(page).to have_link "Delete Shelter"

    click_link "Delete Shelter"

    expect(current_path).to eq("/")

    expect(page).to_not have_content "#{shelter_1.name}"
    expect(page).to have_content "#{shelter_2.name}"

  end
end
