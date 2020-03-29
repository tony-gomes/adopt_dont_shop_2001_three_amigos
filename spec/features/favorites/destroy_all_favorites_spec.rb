require 'rails_helper'

RSpec.describe 'as a visitor with multiple favorites' do

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

  describe 'when I visit favorites index I see a link to remove all favorited pets' do
    context 'when I click that link I am redirected back to /favorites' do
      it 'have no favorited pets is displayed & favorites indicator resets' do

        visit '/'

        within 'nav' do
          click_link "Favorite Pet"
        end

        expect(current_path).to eq("/favorites")

        within '#unfavorite-link' do
          click_link "Unfavorite All Pets"
        end

        expect(current_path).to eq("/favorites")
        expect(page).to have_content("You Have No Favorite Pets")

        within 'nav' do
          expect(page).to have_content("Favorite Pets: 0")
        end
      end
    end
  end
end
