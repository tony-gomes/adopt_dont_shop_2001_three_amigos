require 'rails_helper'

RSpec.describe "As a visitor when I visit a shelter page", type: :feature do
  describe "there is a link to 'Delete Shelter' " do
    it "when I click the link the shelter is deleted and I am returned to the index" do

      shelter = Shelter.create(name: "Joe Exotic's House",
                            address: "7785 Jay St",
                            city: "Lakewood",
                            state: "CO",
                            zip: "80232")

      visit "/shelters/#{shelter.id}"

      expect(page).to have_link "Delete Shelter"

      click_link 'Delete Shelter'

      expect(current_path).to eq("/")
      expect(page).to_not have_content(shelter.name)
      expect(page).to_not have_button('Delete')

    end
  end
end
