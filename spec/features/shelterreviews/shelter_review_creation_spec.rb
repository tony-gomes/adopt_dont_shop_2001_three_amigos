require 'rails_helper'

RSpec.describe "when i visit a shelter show page and click new review link" do
  before(:each) do
    @shelter1 = Shelter.create(name: "Dog-Haven",
                             address:  "1234 Barkers Way",
                             city: "Beagle",
                             state: "MA",
                             zip: "01001")
  end
  describe "i am taken to a review form where i can enter a review without optional image" do
    it "creates a review and returns me to shelter show page where i can view it" do

      visit "shelters/#{@shelter1.id}"

      click_link "New Review"

      expect(current_path).to eq("/shelters/#{@shelter1.id}/reviews/new")
      fill_in 'title', with: "review title"
      fill_in 'rating', with: 5
      fill_in 'content', with: "review content"
      expect(page).to have_content("Image (optional)")

      click_button "Submit Review"

      expect(current_path).to eq("/shelters/#{@shelter1.id}")

      expect(page).to have_content("review title")
      expect(page).to have_content("Rating: 5")
      expect(page).to have_content("review content")

    end
  end

  describe "i am taken to a review form where i can enter a review with optional image" do
    it "creates a review and returns me to shelter show page where i can view it" do

      visit "shelters/#{@shelter1.id}"

      click_link "New Review"

      expect(current_path).to eq("/shelters/#{@shelter1.id}/reviews/new")
      fill_in 'title', with: "review title"
      fill_in 'rating', with: 5
      fill_in 'content', with: "review content"
      fill_in 'review_image', with: "https://via.placeholder.com/150"
      expect(page).to have_content("Image (optional)")

      click_button "Submit Review"

      expect(current_path).to eq("/shelters/#{@shelter1.id}")

      expect(page).to have_css("img[src*='https://via.placeholder.com/150']")
      expect(page).to have_content("review title")
      expect(page).to have_content("Rating: 5")
      expect(page).to have_content("review content")
    end
  end
end
