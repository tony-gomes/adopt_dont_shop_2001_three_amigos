require 'rails_helper'

RSpec.describe "when I visit a shelter show page", type: :feature do
  it "I see a list of reviews for that shelter" do

    shelter1 = Shelter.create(name: "Dog-Haven",
                               address:  "1234 Barkers Way",
                               city: "Beagle",
                               state: "MA",
                               zip: "01001")

    shelter2 = Shelter.create(name: "The Cat Palace",
                               address: "998 Kings Ct",
                               city: "Kings Landing",
                               state: "CA",
                               zip: "90210")

    review1 = shelter1.reviews.create!(review_image: "https://via.placeholder.com/150",
                                        title: "test review 1",
                                        rating: 1,
                                        content: "this review is average at best.")

    review2 = shelter1.reviews.create!(review_image: "https://via.placeholder.com/150",
                                        title: "test review 2",
                                        rating: 2,
                                        content: "this review is average at best.")

    review3 = shelter1.reviews.create!(review_image: "https://via.placeholder.com/150",
                                        title: "test review 3",
                                        rating: 3,
                                        content: "this review is average at best.")

    review4 = shelter2.reviews.create!(review_image: "https://via.placeholder.com/149",
                                        title: "test review 4",
                                        rating: 4000,
                                        content: "this review is missing at best.")

    visit "shelters/#{shelter1.id}"

    expect(page).to have_css("img[src*='https://via.placeholder.com/150']")
    expect(page).to have_content(review1.title)
    expect(page).to have_content(review1.rating)
    expect(page).to have_content(review1.content)

    expect(page).to have_css("img[src*='https://via.placeholder.com/150']")
    expect(page).to have_content(review2.title)
    expect(page).to have_content(review2.rating)
    expect(page).to have_content(review2.content)

    expect(page).to have_css("img[src*='https://via.placeholder.com/150']")
    expect(page).to have_content(review3.title)
    expect(page).to have_content(review3.rating)
    expect(page).to have_content(review3.content)

    expect(page).to have_no_css("img[src*='https://via.placeholder.com/149']")
    expect(page).to have_no_content(review4.title)
    expect(page).to have_no_content(review4.rating)
    expect(page).to have_no_content(review4.content)

  end
end
