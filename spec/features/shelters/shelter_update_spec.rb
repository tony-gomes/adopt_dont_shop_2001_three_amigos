require 'rails_helper'

RSpec.describe 'update shelter', type: :feature do
  describe 'as a visitor when i visit a show page' do
    it 'i can edit the shelter information' do
      shelter = Shelter.create(name: 'Bird Savers',
                               address: "445 Long Wing Way",
                               city: "Kitty Hawk",
                               state:"NC",
                               zip: "27949")

      visit "/shelters/#{shelter.id}"

      expect(page).to have_content("Bird Savers")

      click_link "Update Shelter"

      expect(current_path).to eq("/shelters/#{shelter.id}/edit")

      expect(page).to have_content("Name")
      expect(page).to have_content("Address")
      expect(page).to have_content("City")
      expect(page).to have_content("State")
      expect(page).to have_content("Zip")

      fill_in :name, with: "New Heights Bird Rescue"
      click_button 'Submit'

      expect(current_path).to eq("/shelters/#{shelter.id}/")
      
      shelter.reload
      expect(shelter.name).to eq('New Heights Bird Rescue')
      expect(page).to_not have_content("Bird Savers")
    end
  end
end
