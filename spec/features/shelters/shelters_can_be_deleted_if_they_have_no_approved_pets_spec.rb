require 'rails_helper'

RSpec.describe "if a shelter has no pets with approved apps", type: :feature do
  it "it can be deleted" do

    shelter_1 = Shelter.create(name: "Dog-Haven",
                               address:  "1234 Barkers Way",
                               city: "Beagle",
                               state: "MA",
                               zip: "01001")

    shelter_2 = Shelter.create(name: "The Cat Palace",
                               address: "998 Kings Ct",
                               city: "Kings Landing",
                               state: "CA",
                               zip: "90210")

    pet_1 = shelter_1.pets.create!(name: "Charlotte",
                                   age: 13,
                                   sex: "Female",
                                   adopt_status: "Pending",
                                   image: "https://raw.githubusercontent.com/mikez321/adopt_dont_shop_2001/master/app/assets/images/charlotte.jpg")

    pet_2 = shelter_1.pets.create!(name: "Sydney",
                                   age: 13,
                                   sex: "Female",
                                   image: "https://raw.githubusercontent.com/mikez321/adopt_dont_shop_2001/master/app/assets/images/sydney.jpg")

    pet_3 = shelter_2.pets.create!(name: "Huckleberry",
                                   description: "I love adventure and haircuts!",
                                   age: 8,
                                   sex: "Male",
                                   image: "https://raw.githubusercontent.com/mikez321/adopt_dont_shop_2001/master/app/assets/images/hb.jpg")

    application_1 = PetApplication.create({"name"=>"Jesse", "address"=>"12345 Jesse Ave",
                                           "city"=>"Jesse", "state"=>"CO", "zip"=>"80120", "phone_number"=>"303-867-5309",
                                           "description"=>"Because I'm too cool for school"})

    ApplicationPet.create(pet_id: pet_1.id, pet_application_id: application_1.id)

    visit "/pets"
      expect(page).to have_content("#{pet_1.name}")
      expect(page).to have_content("#{pet_2.name}")
      expect(page).to have_content("#{pet_3.name}")

    visit "/shelters/#{shelter_1.id}"
    expect(page).to_not have_link("Delete Shelter")

    visit "/shelters/#{shelter_2.id}"
    expect(page).to have_link("Delete Shelter")

    visit "/shelters"

    within "#shelter-#{shelter_1.id}" do
      expect(page).to_not have_content("Delete Shelter")
    end

    within "#shelter-#{shelter_2.id}" do
      expect(page).to have_content("Delete Shelter")
    end

    within "#shelter-#{shelter_2.id}" do
      click_link "Delete Shelter"
    end

    expect(current_path).to eq("/")

    expect(page).to have_content("#{shelter_1.name}")
    expect(page).to_not have_content("#{shelter_2.name}")

    visit "/pets"
      expect(page).to have_content("#{pet_1.name}")
      expect(page).to have_content("#{pet_2.name}")
      expect(page).to_not have_content("#{pet_3.name}")

  end
end
