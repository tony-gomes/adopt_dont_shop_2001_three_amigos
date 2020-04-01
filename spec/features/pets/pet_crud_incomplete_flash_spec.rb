require 'rails_helper'

RSpec.describe "as a visitor, when i create or update a pet", type: :feature do
  describe "and click submit form without completing all fields, i see" do
    it "a flash message indicating which fields are missing" do

      shelter = Shelter.create(
        name: "Dog-Haven",
        address:  "1234 Barkers Way",
        city: "Beagle",
        state: "MA",
        zip: "01001"
      )

      pet = shelter.pets.create(
        name: "Charlotte",
        description: "I will do anything for a treat!",
        age: 13,
        sex: "Female",
        image: "https://raw.githubusercontent.com/mikez321/adopt_dont_shop_2001/master/app/assets/images/charlotte.jpg"
      )

      visit "/shelters/#{shelter.id}/pets/new"

      fill_in :description, with: "I love to sleep, but from 3 till 4, I'm ready to hunt! OWWWWWWWW!!!"
      fill_in :age, with: 13
      fill_in :sex, with: "Female"

      click_button "Create Pet"

      expect(page).to have_content("The name field must not be left blank")

      visit "/shelters/#{shelter.id}/pets/new"

      fill_in :name, with: "Sydney"
      fill_in :description, with: "I love to sleep, but from 3 till 4, I'm ready to hunt! OWWWWWWWW!!!"
      fill_in :sex, with: "Female"

      click_button "Create Pet"

      expect(page).to have_content("The age field must not be left blank")

      visit "/shelters/#{shelter.id}/pets/new"

      fill_in :name, with: "Sydney"
      fill_in :description, with: "I love to sleep, but from 3 till 4, I'm ready to hunt! OWWWWWWWW!!!"
      fill_in :age, with: 13

      click_button "Create Pet"

      expect(page).to have_content("The sex field must not be left blank")

      visit "/shelters/#{shelter.id}/pets/new"

      click_button "Create Pet"

      expect(page).to have_content("The name field must not be left blank")
      expect(page).to have_content("The age field must not be left blank")
      expect(page).to have_content("The sex field must not be left blank")

      visit "/pets/#{pet.id}/edit"

      fill_in :name, with: ""
      fill_in :age, with: 13
      fill_in :sex, with: "Female"

      click_on 'Submit'

      expect(page).to have_content("The name field must not be left blank")

      visit "/pets/#{pet.id}/edit"

      fill_in :name, with: "Charlotte"
      fill_in :age, with: ""
      fill_in :sex, with: "Female"

      click_on 'Submit'

      expect(page).to have_content("The age field must not be left blank")

      visit "/pets/#{pet.id}/edit"

      fill_in :name, with: "Charlotte"
      fill_in :age, with: 13
      fill_in :sex, with: ""

      click_on 'Submit'

      expect(page).to have_content("The sex field must not be left blank")

      visit "/pets/#{pet.id}/edit"

      fill_in :name, with: ""
      fill_in :age, with: ""
      fill_in :sex, with: ""

      click_on 'Submit'

      expect(page).to have_content("The name field must not be left blank")
      expect(page).to have_content("The age field must not be left blank")
      expect(page).to have_content("The sex field must not be left blank")

    end

  end

end
