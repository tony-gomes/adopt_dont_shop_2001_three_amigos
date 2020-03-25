require 'rails_helper'

RSpec.describe "when I don't enter required information I get an error message" do
  describe "and I am returned to the new review page" do
    it "when all required information is provided the review is created" do

      shelter1 = Shelter.create(name: "Dog-Haven",
                               address:  "1234 Barkers Way",
                               city: "Beagle",
                               state: "MA",
                               zip: "01001")


      visit "/shelters/#{shelter1.id}/reviews/new"

      fill_in 'title', with: "review title"
      fill_in 'rating', with: 5

      click_button "Submit Review"

      expect(current_path).to eq("/shelters/#{shelter1.id}/reviews/new")

      expect(page).to have_content("Review must include a title, rating, and content to be submitted.")

      fill_in 'title', with: "review title"
      fill_in 'rating', with: 5
      fill_in 'content', with: "review content"

      click_button "Submit Review"

      expect(current_path).to eq("/shelters/#{shelter1.id}")

      expect(page).to have_content("review title")
      expect(page).to have_content("review content")
    end
  end
end
