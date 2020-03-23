require 'rails_helper'

RSpec.describe "when I visit the shelter page", type: :feature do
  describe "and I click a link for Create Pet" do
    it "I am taken to a new page and see a form to create a pet" do

      shelter_1 = Shelter.create(name: "Dog-Haven",
                                 address:  "1234 Barkers Way",
                                 city: "Beagle",
                                 state: "MA",
                                 zip: "01001")

      visit "/shelters/#{shelter_1.id}/pets"

      click_link "Create Pet"

      expect(current_path).to eq("/shelters/#{shelter_1.id}/pets/new")

      fill_in :image, with: "https://raw.githubusercontent.com/mikez321/adopt_dont_shop_2001/master/app/assets/images/sydney.jpg"
      fill_in :name, with: "Sydney"
      fill_in :description, with: "I love to sleep, but from 3 till 4, I'm ready to hunt! OWWWWWWWW!!!"
      fill_in :age, with: 13
      fill_in :sex, with: "Female"

      click_button "Create Pet"

      expect(current_path).to eq("/shelters/#{shelter_1.id}/pets")

      expect(page).to have_content("Sydney")
      expect(page).to have_content("I love to sleep, but from 3 till 4, I'm ready to hunt! OWWWWWWWW!")
      expect(page).to have_content("13")
      expect(page).to have_content("Female")
      expect(page).to have_content("Adoptable")
    end
  end
end
