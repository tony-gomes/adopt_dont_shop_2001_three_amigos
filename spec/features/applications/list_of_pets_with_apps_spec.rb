require 'rails_helper'

RSpec.describe "After a pet has one or more applications on it and I visit /favorites", type: :feature do
  describe "there will be a section with all the pets that have open apps on them" do
    it "each pet's name is a link to that pets show page" do

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

      visit("/favorites")

      within ".application-submitted-pets" do
        expect(page).to_not have_content("#{pet_1.name}")
      end

      click_link "Adopt Favorite Pets"

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

      within ".application-submitted-pets" do
        expect(page).to have_link("#{pet_1.name}")
      end

      within ".application-submitted-pets" do
        click_link "#{pet_1.name}"
      end

      expect(current_path).to eq("/pets/#{pet_1.id}")


    end
  end
end
