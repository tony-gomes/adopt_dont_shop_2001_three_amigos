require 'rails_helper'

RSpec.describe "when i visit a pets show page", type: :feature do
  describe "i see a link to update the pet called 'Update Pet'" do
    describe "when the link is clicked i can update image name description and sex" do
      it "then i click the button 'Submit' and see the pets page with updated info" do

        shelter_1 = Shelter.create(name: "Dog-Haven",
                                   address:  "1234 Barkers Way",
                                   city: "Beagle",
                                   state: "MA",
                                   zip: "01001")

        pet_1 = shelter_1.pets.create!(name: "Charlotte",
                                       description: "I will do anything for a treat!",
                                       age: 13,
                                       sex: "Female",
                                       image: "https://raw.githubusercontent.com/mikez321/adopt_dont_shop_2001/master/app/assets/images/charlotte.jpg")
        visit "/pets/#{pet_1.id}"

        click_link "Update Pet"

        expect(current_path).to eq("/pets/#{pet_1.id}/edit")

        expect(page).to have_content("Image")
        expect(page).to have_content("Name")
        expect(page).to have_content("Description")
        expect(page).to have_content("Age")
        expect(page).to have_content("Sex")

        fill_in :name, with: "Hairy Dogger"
        fill_in :image, with: "https://s3.ap-south-1.amazonaws.com/hsdreams1/pins/2019/04/big/ac58bb8be9088a8ab82467bd30640ae8.jpeg"

        click_button "Submit"

        expect(current_path).to eq("/pets/#{pet_1.id}")
        pet_1.reload

        expect(page).to_not have_content("Charlotte")
        expect(page).to_not have_css("img[src*='images/charlotte.jpg']")
        expect(page).to have_content("Hairy Dogger")
        expect(page).to have_css("img[src*='#{pet_1.image}']")

      end
    end
  end
end
