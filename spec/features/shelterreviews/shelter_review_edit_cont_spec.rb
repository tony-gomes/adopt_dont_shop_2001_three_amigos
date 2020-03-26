require 'rails_helper'

RSpec.describe "when I don't enter required information I get an error message" do
  before(:each) do
    @shelter_1 = Shelter.create(name: "Dog-Haven",
      address:  "1234 Barkers Way",
      city: "Beagle",
      state: "MA",
      zip: "01001")

    @review_1 = @shelter_1.reviews.create!(review_image: "https://via.placeholder.com/150",
      title: "test review 1",
      rating: 1,
      content: "this review is average at best.")
    end
      describe "and I am returned to the edit review page" do


    it "content is required to submit a review" do

      visit "/shelters/#{@shelter_1.id}/reviews/#{@review_1.id}/edit"

      fill_in 'content', with: ""

      click_button "Submit Review"

      expect(current_path).to eq("/shelters/#{@shelter_1.id}/reviews/#{@review_1.id}/edit")

      expect(page).to have_content("Review must include a title, rating, and content to be submitted.")

      fill_in 'title', with: "review title"
      fill_in 'rating', with: 5
      fill_in 'content', with: "review content"

      click_button "Submit Review"

      expect(current_path).to eq("/shelters/#{@shelter_1.id}")

      expect(page).to have_content("review title")
      expect(page).to have_content("review content")

    end
  end

      describe "title is also required" do
        it "and will also give an error if not filled in" do

      visit "/shelters/#{@shelter_1.id}/reviews/#{@review_1.id}/edit"

      fill_in 'title', with: ""

      click_button "Submit Review"

      expect(current_path).to eq("/shelters/#{@shelter_1.id}/reviews/#{@review_1.id}/edit")

      expect(page).to have_content("Review must include a title, rating, and content to be submitted.")

      fill_in 'title', with: "review title"
      fill_in 'rating', with: 5
      fill_in 'content', with: "review content"

      click_button "Submit Review"

      expect(current_path).to eq("/shelters/#{@shelter_1.id}")

      expect(page).to have_content("review title")
      expect(page).to have_content("review content")
    end
  end

  describe "rating is also required" do
    it "and will have an error if it is not filled in" do

      visit "/shelters/#{@shelter_1.id}/reviews/#{@review_1.id}/edit"

      fill_in 'rating', with: ""

      click_button "Submit Review"

      expect(current_path).to eq("/shelters/#{@shelter_1.id}/reviews/#{@review_1.id}/edit")

      expect(page).to have_content("Review must include a title, rating, and content to be submitted.")

      fill_in 'title', with: "review title"
      fill_in 'rating', with: 5
      fill_in 'content', with: "review content"

      click_button "Submit Review"

      expect(current_path).to eq("/shelters/#{@shelter_1.id}")

      expect(page).to have_content("review title")
      expect(page).to have_content("review content")
    end
  end
end
