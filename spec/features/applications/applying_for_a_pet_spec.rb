require 'rails_helper'

RSpec.describe "When I have added pets to my favorites list and and I visit my favorites index", type: :feature do
  describe "I click the link to adopt my favorited pets and am taken to an application form" do
    describe "I can see the pets I want to adopt at the top of the form " do
      it "and when I fill out all the fields of the form I see a message saying my application was submitted" do

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

        visit "/pets/#{pet_3.id}"

        within "section" do
          click_link "Favorite Pet"
        end

        visit("/favorites")

        click_link "Adopt Favorite Pets"

        expect(current_path).to eq("/pet_applications/new")

        within("#pet-#{pet_1.id}") do
          check "#{pet_1.name}"
        end

        within("#pet-#{pet_2.id}") do
          check "#{pet_2.name}"
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

        expect(page).to_not have_content("#{pet_1.name}")
        expect(page).to_not have_content("#{pet_2.name}")
        expect(page).to have_content("#{pet_3.name}")
      end
    end
  end
end
