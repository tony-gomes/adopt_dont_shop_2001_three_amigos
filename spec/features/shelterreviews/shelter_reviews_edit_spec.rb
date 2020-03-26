require 'rails_helper'

RSpec.describe 'as a visitor the shelter#show page has an edit link next to each review' do
  it 'when I click the edit link I am taken to an edit shelter page'  do
    shelter_1 = Shelter.create(name: "Dog-Haven",
                               address:  "1234 Barkers Way",
                               city: "Beagle",
                               state: "MA",
                               zip: "01001")

    review_1 = shelter_1.reviews.create!(review_image: "https://via.placeholder.com/150",
                                         title: "test review 1",
                                         rating: 1,
                                         content: "this review is average at best.")

    review_2 = shelter_1.reviews.create!(review_image: "https://via.placeholder.com/150",
                                         title: "test review 2",
                                         rating: 4,
                                         content: "this review is average at best.")

    review_3 = shelter_1.reviews.create!(review_image: "https://via.placeholder.com/150",
                                         title: "test review 3",
                                         rating: 3,
                                         content: "this review is average at best.")

    visit "shelters/#{shelter_1.id}"

    within("#review-#{review_1.id}") do
      click_link "Edit Review"
    end

    expect(current_path).to eq("/shelters/#{shelter_1.id}/reviews/#{review_1.id}/edit")

    fill_in :review_image, with: "https://via.placeholder.com/250"
    fill_in :title, with: "Test Edit Review 1"
    fill_in :rating, with: 3
    fill_in :content, with: "this is an edited review now bc of the first test"

    click_button "Submit"

    expect(current_path).to eq("/shelters/#{shelter_1.id}")

    review_1.reload

    within "#review-#{review_1.id}" do
      expect(review_1.review_image).to eq("https://via.placeholder.com/250")
      expect(review_1.title).to eq("Test Edit Review 1")
      expect(review_1.rating).to eq(3)
      expect(review_1.content).to eq("this is an edited review now bc of the first test")
    end

    page.has_css?("img[src*='https://via.placeholder.com/150']")
    expect(page).to have_content(review_2.title)
    expect(page).to have_content(review_2.rating)
    expect(page).to have_content(review_2.content)

    page.has_css?("img[src*='https://via.placeholder.com/150']")
    expect(page).to have_content(review_3.title)
    expect(page).to have_content(review_3.rating)
    expect(page).to have_content(review_3.content)
  end
end
