require 'rails_helper'

RSpec.describe "when I visit a pets show page there is a favorite link next to each pet", type: :feature do

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

    describe "when I click the link to favorite the pet I am taken to the pets show page" do
      it "I see a flash message saying that the pet has been added to my favorites" do

        visit "/pets/#{@pet_1.id}"

        within "section" do
          click_link "Favorite Pet"
        end

        expect(current_path).to eq("/pets/#{@pet_1.id}")
        expect(page).to have_content("Pet added to favorites")

      end
    end

    it "when a pet is favorited the favorite indiciator on the nav bar incrementes by 1" do

      visit "/pets/#{@pet_2.id}"

        within "nav" do
          expect(page).to have_content("Favorite Pets: 0")
        end

        within "section" do
          click_link "Favorite Pet"
        end

        within "nav" do
          expect(page).to have_content("Favorite Pets: 1")
        end
    end
  end
