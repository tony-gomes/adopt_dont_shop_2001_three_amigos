require 'rails_helper'

RSpec.describe "when I visit a shelter show page ther is a link to delete a review" do

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

    @review_2 = @shelter_1.reviews.create!(review_image: "https://via.placeholder.com/100",
                                       title: "test review 2",
                                       rating: 5,
                                       content: "this review is better than the last one.")
  end

describe "when I click the link i am returned to the shelters show page" do
 it "and the review is no longer there" do

      visit "/shelters/#{@shelter_1.id}"

        expect(page).to have_content("#{@review_1.title}")
        expect(page).to have_content("#{@review_1.content}")

        expect(page).to have_content("#{@review_2.title}")
        expect(page).to have_content("#{@review_2.content}")

      within("#review-#{@review_1.id}") do
        click_link "Delete Review"
      end
      
      expect(current_path).to eq("/shelters/#{@shelter_1.id}")

        expect(page).to_not have_content("#{@review_1.title}")
        expect(page).to_not have_content("#{@review_1.content}")

        expect(page).to have_content("#{@review_2.title}")
        expect(page).to have_content("#{@review_2.content}")

    end
  end
end
