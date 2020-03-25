require 'rails_helper'

RSpec.describe 'as a visitor the shelter#show page has an edit link next to each review' do
  it 'when I click the edit link I am taken to an edit shelter page'  do
    shelter1 = Shelter.create(name: "Dog-Haven",
                              address:  "1234 Barkers Way",
                              city: "Beagle",
                              state: "MA",
                              zip: "01001")

    review1 = shelter1.reviews.create!(review_image: "https://via.placeholder.com/150",
                                       title: "test review 1",
                                       rating: 1,
                                       content: "this review is average at best.")

    review2 = shelter1.reviews.create!(review_image: "https://via.placeholder.com/150",
                                       title: "test review 2",
                                       rating: 4,
                                       content: "this review is average at best.")

    review3 = shelter1.reviews.create!(review_image: "https://via.placeholder.com/150",
                                       title: "test review 3",
                                       rating: 3,
                                       content: "this review is average at best.")

    review4 = shelter2.reviews.create!(review_image: "https://via.placeholder.com/149",
                                       title: "test review 4",
                                       rating: 4,
                                       content: "this review is missing at best.")

    visit "shelters/#{shelter1.id}"


  end
end
