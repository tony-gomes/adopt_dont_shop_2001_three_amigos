require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do

    before(:each) do

        @shelter_1 = Shelter.create!(
          name: "Dog-Haven",
          address:  "1234 Barkers Way",
          city: "Beagle",
          state: "MA",
          zip: "01001"
        )

        @pet_1 = @shelter_1.pets.create!(
          name: "Charlotte",
          description: "I will do anything for a treat!",
          age: 13,
          sex: "Female",
          image: "https://raw.githubusercontent.com/mikez321/adopt_dont_shop_2001/master/app/assets/images/charlotte.jpg"
        )

        @pet_2 = @shelter_1.pets.create!(
          name: "Sydney",
          age: 13,
          sex: "Female",
          image: "https://raw.githubusercontent.com/mikez321/adopt_dont_shop_2001/master/app/assets/images/sydney.jpg")
    end

    describe "When I have no pets in my favorites & visit /favorites" do
      it "I see text saying that I have no favorited pets" do
        visit '/favorites'

        within 'section' do
          click_link "Unfavorite All Pets"
        end

        within 'nav' do
          expect(page).to have_content("Favorite Pets: 0")
        end

        expect(page).to have_content("You Have No Favorite Pets")
      end
    end
  end
