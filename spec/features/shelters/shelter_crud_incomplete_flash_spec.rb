require 'rails_helper'

RSpec.describe "as a visitor, when i create or update a shelter", type: :feature do
  describe "and click submit form without completing all fields, i see" do
    it "a flash message indicating which fields are missing" do

      shelter = Shelter.create(
        name: "Dog-Haven",
        address:  "1234 Barkers Way",
        city: "Beagle",
        state: "MA",
        zip: "01001"
      )

      visit "/shelters/new"

      fill_in 'address', with: "1234 Floor"
      fill_in 'city', with: "Denver"
      fill_in 'state', with: "CO"
      fill_in 'zip', with: "80232"

      click_on 'Create Shelter'

      expect(page).to have_content("The name field must not be left blank")

      visit "/shelters/new"

      fill_in 'name', with: "The Dog Rescuerer"
      fill_in 'city', with: "Denver"
      fill_in 'state', with: "CO"
      fill_in 'zip', with: "80232"

      click_on 'Create Shelter'

      expect(page).to have_content("The address field must not be left blank")

      visit "/shelters/new"

      fill_in 'name', with: "The Dog Rescuerer"
      fill_in 'address', with: "1234 Floor"
      fill_in 'state', with: "CO"
      fill_in 'zip', with: "80232"

      click_on 'Create Shelter'

      expect(page).to have_content("The city field must not be left blank")

      visit "/shelters/new"

      fill_in 'name', with: "The Dog Rescuerer"
      fill_in 'address', with: "1234 Floor"
      fill_in 'city', with: "Denver"
      fill_in 'zip', with: "80232"

      click_on 'Create Shelter'

      expect(page).to have_content("The state field must not be left blank")

      visit "/shelters/new"

      fill_in 'name', with: "The Dog Rescuerer"
      fill_in 'address', with: "1234 Floor"
      fill_in 'city', with: "Denver"
      fill_in 'state', with: "CO"

      click_on 'Create Shelter'

      expect(page).to have_content("The zip field must not be left blank")

      visit "/shelters/new"

      click_on 'Create Shelter'

      expect(page).to have_content("The name field must not be left blank")
      expect(page).to have_content("The address field must not be left blank")
      expect(page).to have_content("The city field must not be left blank")
      expect(page).to have_content("The state field must not be left blank")
      expect(page).to have_content("The zip field must not be left blank")

      visit "/shelters/#{shelter.id}/edit"

      fill_in 'name', with: ""

      click_on "Submit"

      expect(page).to have_content("The name field must not be left blank")

      visit "/shelters/#{shelter.id}/edit"

      fill_in 'address', with: ""

      click_on "Submit"

      expect(page).to have_content("The address field must not be left blank")

      visit "/shelters/#{shelter.id}/edit"

      fill_in 'city', with: ""

      click_on "Submit"

      expect(page).to have_content("The city field must not be left blank")

      visit "/shelters/#{shelter.id}/edit"

      fill_in 'state', with: ""

      click_on "Submit"

      expect(page).to have_content("The state field must not be left blank")

      visit "/shelters/#{shelter.id}/edit"

      fill_in 'zip', with: ""

      click_on "Submit"

      expect(page).to have_content("The zip field must not be left blank")

      visit "/shelters/#{shelter.id}/edit"

      fill_in 'name', with: ""
      fill_in 'address', with: ""
      fill_in 'city', with: ""
      fill_in 'state', with: ""
      fill_in 'zip', with: ""

      click_on "Submit"

      expect(page).to have_content("The name field must not be left blank")
      expect(page).to have_content("The address field must not be left blank")
      expect(page).to have_content("The city field must not be left blank")
      expect(page).to have_content("The state field must not be left blank")
      expect(page).to have_content("The zip field must not be left blank")

    end

  end

end
