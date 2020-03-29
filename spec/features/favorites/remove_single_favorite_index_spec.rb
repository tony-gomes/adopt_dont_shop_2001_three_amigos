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
      image: "https://raw.githubusercontent.com/mikez321/adopt_dont_shop_2001/master/app/assets/images/sydney.jpg"
      )
  end
  describe "When I have added pets to my favorites list & I visit /favorites" do
    context "I see a link to remove that pet from my favorites next to each pet" do
      context "If I click on remove link a delete request is sent to /favorites/:pet_id" do
        context "I am redirected back to favorites where I no longer see that pet" do
          it "I also see that the favorites indicator has decremented by 1" do
            visit "/pets/#{@pet_1.id}"
            expect(current_path).to eq("/pets/#{@pet_1.id}")
            within 'section' do
              click_link "Favorite Pet"
            end
            expect(page).to have_content("Pet added to favorites")
            visit "/pets/#{@pet_2.id}"
            expect(current_path).to eq("/pets/#{@pet_2.id}")
            within 'section' do
              click_link "Favorite Pet"
            end
            expect(page).to have_content("Pet added to favorites")
            within 'nav' do
              expect(page).to have_content("Favorite Pets: 2")
              click_link "Favorite Pet"
            end
            expect(current_path).to eq("/favorites")
            within "#favorite-#{@pet_1.id}" do
              click_link "Remove Favorite"
            end
            expect(current_path).to eq("/favorites")
            within 'nav' do
              expect(page).to have_content("Favorite Pets: 1")
            end
            expect(current_path).to eq("/favorites")
            within "#favorite-#{@pet_2.id}" do
              click_link "Remove Favorite"
            end
            expect(current_path).to eq("/favorites")
            within 'nav' do
              expect(page).to have_content("Favorite Pets: 0")
            end
          end
        end
      end
    end
  end
end
