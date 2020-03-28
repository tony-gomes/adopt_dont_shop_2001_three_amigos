require 'rails_helper'

RSpec.describe "As a visitor that has favorited a pet" do

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

      visit "/pets/#{@pet_1.id}"

      within "section" do
        click_link "Favorite Pet"
      end

      within "nav" do
        expect(page).to have_content("Favorite Pets: 1")
      end
  end

  context "when I visit that pet's show I no longer see a link to favorite that pet" do
    it "But I see a link to remove that pet from my favorites" do
      visit '/pets/#{@pet_1.id}'

      within "section" do
        expect(page).to have_no_content("Favorite Pet")
        expect(page).to have_link("Remove Pet")
      end

      expect(current_path).to eq("/pets/#{@pet_1.id}")

    end
  end

  context "when I click remove pet a delete request is sent to /favorites/:pet_id" do
    it "I am redirected back to that pets show page where I see removed flash message" do

      expect(current_path).to eq("/pets/#{@pet_1.id}")

        within "section" do
          click_link "Remove Pet"
        end

        expect(current_path).to eq("/pets/#{@pet_1.id}")
        expect(page).to have_content("Pet removed from favorites.")

      end
    end

  it "And I see a link to favorite the pet & favorites indicator decremented by 1" do

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
