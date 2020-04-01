require 'rails_helper'

RSpec.describe "When I fill out an incomplete application for a pet", type: :feature do
  describe "and I click on the submit application button" do
    it "I am redirected back to new applicaton form and see an error message that I must complete the form" do

      shelter_1 = Shelter.create(
        name: "Dog-Haven",
        address:  "1234 Barkers Way",
        city: "Beagle",
        state: "MA",
        zip: "01001"
      )

      pet_1 = shelter_1.pets.create!(
        name: "Charlotte",
        age: 13,
        sex: "Female",
        image: "https://raw.githubusercontent.com/mikez321/adopt_dont_shop_2001/master/app/assets/images/charlotte.jpg"
      )

      pet_2 = shelter_1.pets.create!(
        name: "Sydney",
        age: 13,
        sex: "Female",
        image: "https://raw.githubusercontent.com/mikez321/adopt_dont_shop_2001/master/app/assets/images/sydney.jpg"
      )

      pet_3 = shelter_1.pets.create!(
        name: "Huckleberry",
        description: "I love adventure and haircuts!",
        age: 8,
        sex: "Male",
        image: "https://raw.githubusercontent.com/mikez321/adopt_dont_shop_2001/master/app/assets/images/hb.jpg"
      )

      visit "/pets/#{pet_1.id}"

      within "section" do
        click_link "Favorite Pet"
      end

      visit "/pets/#{pet_2.id}"

      within "section" do
        click_link "Favorite Pet"
      end

      visit("/favorites")

      click_link "Adopt Favorite Pets"

      expect(current_path).to eq("/pet_applications/new")

      within("#pet-#{pet_1.id}") do
        check "#{pet_1.name}"
      end

      fill_in :name, with: "Jesse"
      fill_in :address, with: "12345 Jesse Ave"
      fill_in :city, with: "Jesse"
      fill_in :state, with: "CO"
      fill_in :zip, with: "80120"
      fill_in :description, with: "Because I'm too cool for school"

      click_button "Submit Application"

      expect(current_path).to eq("/pet_applications/new")
      expect(page).to have_content("You must fill out all all of the application before it can be submitted.")

      within("#pet-#{pet_1.id}") do
        check "#{pet_1.name}"
      end

      fill_in :name, with: "Jesse"
      fill_in :address, with: "12345 Jesse Ave"
      fill_in :city, with: "Jesse"
      fill_in :state, with: "CO"
      fill_in :zip, with: "80120"
      fill_in :phone_number, with: "303-867-5309"
      fill_in :description, with: "Because I'm too cool for school"

      click_button "Submit Application"

      expect(current_path).to eq("/favorites")
      expect(page).to have_content("Your application was submitted successfully!")

      within ".favorited-pets" do
        expect(page).to_not have_content("#{pet_1.name}")
        expect(page).to have_content("#{pet_2.name}")
      end

      within ".application-submitted-pets" do
        expect(page).to have_content("#{pet_1.name}")
      end
    end
  end
end
