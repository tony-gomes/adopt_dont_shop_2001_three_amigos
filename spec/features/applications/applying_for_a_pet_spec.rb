require 'rails_helper'

RSpec.describe "When I have added pets to my favorites list and and I visit my favorites index" do
  describe "I click the link to adopt my favorited pets and am taken to an application form" do
    describe "I can see the pets I want to adopt at the top of the form " do
      it "and when I fill out all the fields of the form I see a message saying my application was submitted" do

        shelter_1 = Shelter.create(name: "Dog-Haven",
                                   address:  "1234 Barkers Way",
                                   city: "Beagle",
                                   state: "MA",
                                   zip: "01001")

        pet_1 = shelter_1.pets.create!(name: "Charlotte",
                                       age: 13,
                                       sex: "Female",
                                       image: "https://raw.githubusercontent.com/mikez321/adopt_dont_shop_2001/master/app/assets/images/charlotte.jpg")

        pet_2 = shelter_1.pets.create!(name: "Sydney",
                                       age: 13,
                                       sex: "Female",
                                       image: "https://raw.githubusercontent.com/mikez321/adopt_dont_shop_2001/master/app/assets/images/sydney.jpg")

        pet_3 = shelter_1.pets.create!(name: "Huckleberry",
                                       description: "I love adventure and haircuts!",
                                       age: 8,
                                       sex: "Male",
                                       image: "https://raw.githubusercontent.com/mikez321/adopt_dont_shop_2001/master/app/assets/images/hb.jpg")
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

        check "Charlotte"
        check "Sydney"

        fill_in :name, with: "Jesse"
        fill_in :Address, with: "12345 Jesse Ave"
        fill_in :City, with: "Jesse"
        fill_in :State, with: "CO"
        fill_in :Zip, with: "80120"
        fill_in :Phone_number, with: "303-867-5309"
        fill_in :Description, with: "Because I'm too cool for school"

        click_link "Submit Application"

        #within something
        expect(page).to have_content("Your application for was submitted successfully!")
        expect(page).to have_content("Pets: #{pet_1.name}")
        expect(page).to have_content("Pets: #{pet_2.name}")
        #end

        expect(current_path).to eq("/favorite")

        expect(page).to_not have_content("#{pet_1.name}")
        expect(page).to_not have_content("#{pet_2.name}")
        expect(page).to have_content("#{pet_3.name}")
      end
    end
  end
end
#
# @contents = [1, 2]
# @pending = [3]
#
# @contents = { :favorites => [1],
#   :pending => [3, 2] }

# As a visitor
# When I have added pets to my favorites list
# And I visit my favorites page ("/favorites")
# I see a link for adopting my favorited pets
# When I click that link I'm taken to a new application form
# At the top of the form, I can select from the pets of which I've favorited for which I'd like this application to apply towards (can be more than one)
# When I select one or more pets, and fill in my
# - Name
# - Address
# - City
# - State
# - Zip
# - Phone Number
# - Description of why I'd make a good home for this/these pet(s)
# And I click on a button to submit my application
# I see a flash message indicating my application went through for the pets that were selected
# And I'm taken back to my favorites page where I no longer see the pets for which I just applied listed as favorites
