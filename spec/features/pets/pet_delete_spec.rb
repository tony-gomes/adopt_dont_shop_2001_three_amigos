require 'rails_helper'

RSpec.describe "when i visit a pets show page", type: :feature do
  describe "i see a 'Delete Link' link to delete the pet and if i click the link" do
    it "the pet is deleted and i am returned to the pets index" do

      shelter_1 = Shelter.create(name: "Dog-Haven",
                                 address:  "1234 Barkers Way",
                                 city: "Beagle",
                                 state: "MA",
                                 zip: "01001")

      pet_1 = shelter_1.pets.create!(name: "Charlotte",
                                     age: 13,
                                     sex: "Female",
                                     image: "https://raw.githubusercontent.com/mikez321/adopt_dont_shop_2001/master/app/assets/images/charlotte.jpg")

      visit "/pets/#{pet_1.id}"

      expect(page).to have_css("img[src*='#{pet_1.image}']")
      expect(page).to have_content(pet_1.name)
      expect(page).to have_content(pet_1.age)
      expect(page).to have_content(pet_1.sex)

      click_link "Delete Pet"

      expect(current_path).to eq("/pets")

      expect(page).to_not have_css("#pet-#{pet_1.id}")
    end
  end
end
