require 'rails_helper'

RSpec.describe "as a visitor, when i visit pet show applications page", type: :feature do
  it "and that pet has no applications, i see a message stating there are none." do

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

    application_1 = PetApplication.create({"name"=>"Jesse", "address"=>"12345 Jesse Ave",
      "city"=>"Jesse", "state"=>"CO", "zip"=>"80120", "phone_number"=>"303-867-5309",
      "description"=>"Because I'm too cool for school"})

    ApplicationPet.create(pet_id: pet_1.id, pet_application_id: application_1.id)

    visit "/pets/#{pet_1.id}"
    click_link "All Applications"

    expect(current_path).to eq("/pets/#{pet_1.id}/applications")
    expect(page).to have_link("#{application_1.name}", href:"/pet_applications/#{application_1.id}")

    visit "/pets/#{pet_2.id}"
    click_link "All Applications"

    expect(page).to have_content("There are no applications for #{pet_2.name} yet.")

  end
end

# User Story 21, Pet Applications Index Page When No Applications
#
# As a visitor
# When I visit a pet applications index page for a pet that has no applications on them
# I see a message saying that there are no applications for this pet yet
