require 'rails_helper'

RSpec.describe "when i visit a pet show page and click the applications link", type: :feature do
  it "i see each applicant's name as a link to that application show page" do

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

    application_1 = PetApplication.create({"name"=>"Jesse", "address"=>"12345 Jesse Ave",
      "city"=>"Jesse", "state"=>"CO", "zip"=>"80120", "phone_number"=>"303-867-5309",
      "description"=>"Because I'm too cool for school"})

    application_2 = PetApplication.create({"name"=>"Mike", "address"=>"12345 Mike Ave",
      "city"=>"Mikeville", "state"=>"CO", "zip"=>"80120", "phone_number"=>"123-456-7890",
      "description"=>"They're my pets already."})

    ApplicationPet.create(pet_id: pet_1.id, pet_application_id: application_1.id)
    ApplicationPet.create(pet_id: pet_1.id, pet_application_id: application_2.id)
    ApplicationPet.create(pet_id: pet_2.id, pet_application_id: application_2.id)

    visit "/pets/#{pet_1.id}"
    click_link "All Applications"

    expect(current_path).to eq("/pets/#{pet_1.id}/applications")
    expect(page).to have_link("#{application_1.name}", href:"/pet_applications/#{application_1.id}")
    expect(page).to have_link("#{application_2.name}", href:"/pet_applications/#{application_2.id}")

    visit "/pets/#{pet_2.id}"
    click_link "All Applications"

    expect(current_path).to eq("/pets/#{pet_2.id}/applications")
    expect(page).to have_no_link("#{application_1.name}", href:"/pet_applications/#{application_1.id}")
    expect(page).to have_link("#{application_2.name}", href:"/pet_applications/#{application_2.id}")

    visit "/pets/#{pet_3.id}"
    click_link "All Applications"

    expect(current_path).to eq("/pets/#{pet_3.id}/applications")
    expect(page).to have_no_link("#{application_1.name}", href:"/pet_applications/#{application_1.id}")
    expect(page).to have_no_link("#{application_2.name}", href:"/pet_applications/#{application_2.id}")

  end
end
