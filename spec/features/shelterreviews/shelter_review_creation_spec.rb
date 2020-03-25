require 'rails_helper'

RSpec.describe "when i visit a shelter show page and click new review link" do
  describe "i am taken to a review form where i can enter a review and optional image" do
    it "creates a review and returns me to shelter show page where i can view it" do

      shelter1 = Shelter.create(name: "Dog-Haven",
                               address:  "1234 Barkers Way",
                               city: "Beagle",
                               state: "MA",
                               zip: "01001")

      visit "shelters/#{shelter1.id}"

      click_link "New Review"

      expect(current_path).to eq("/shelters/#{shelter1.id}/reviews/new")
      fill_in 'title', with: "review title"
      fill_in 'rating', with: 5
      fill_in 'content', with: "review content"
      expect(page).to have_content("Image (optional)")

      click_button "Submit Review"

      expect(current_path).to eq("/shelters/#{shelter1.id}")

      expect(page).to have_content("review title")
      expect(page).to have_content("Rating: 5")
      expect(page).to have_content("review content")

    end
  end
end


# As a visitor,
# When I visit a shelter's show page
# I see a link to add a new review for this shelter.
# When I click on this link, I am taken to a new review path
# On this new page, I see a form where I must enter:
# - title
# - rating
# - content
# I also see a field where I can enter an optional image (web address)
# When the form is submitted, I should return to that shelter's show page
# and I can see my new review
