require 'rails_helper'

RSpec.describe "when I visit a shelter show page ther is a link to delete a review" do
  describe "when I click the link i am returned to the shelters show page" do
    it "and the review is no longer there" do

      shelter1 = Shelter.create(name: "Dog-Haven",
                               address:  "1234 Barkers Way",
                               city: "Beagle",
                               state: "MA",
                               zip: "01001")

      review1 = shelter1.reviews.create!(review_image: "https://via.placeholder.com/150",
                                         title: "test review 1",
                                         rating: 1,
                                         content: "this review is average at best.")


      visit "/shelters/#{shelter1.id}"

      expect(page).to have_content("#{review1.title}")
      expect(page).to have_content("#{review1.content}")

      click_link "Delete Review"

      expect(current_path).to eq("/shelters/#{shelter1.id}")

      expect(page).to_not have_content("#{review1.title}")
      expect(page).to_not have_content("#{review1.content}")

    end
  end
end
