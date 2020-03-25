require 'rails_helper'

RSpec.describe 'as a visitor the shelter#show page has an edit link next to each review' do
  it 'when I click the edit link I am taken to an edit shelter page'  do
    shelter1 = Shelter.create(name: "Dog-Haven",
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

    visit "shelters/#{shelter1.id}"

    click_on "Edit Review 1" # need unique id generated w/ shelter_id & review_id to target link

    expect(current_path).to eq("/shelters/#{shelter_1.id}/reviews/#{review_1.id}/edit")

    fill_in :review_image, with: "https://via.placeholder.com/250"
    fill_in :title, with: "Test Edit Review 1"
    fill_in :rating, with: 3
    fill_in :content, with: "this is an edited review now bc of the first test"

    click_button "Submit"

    within "review-#{review_1.id}" do
      expect(review_1.review_image).to eq("https://via.placeholder.com/250")
      expect(review_1.title).to eq("Test Edit Review 1")
      expect(review_1.rating).to eq(3)
      expect(review_1.content).to eq("this is an edited review now bc of the first test")
    end

    page.has_css?("img[src*='https://via.placeholder.com/150']")
    expect(page).to have_content(review2.title)
    expect(page).to have_content(review2.rating)
    expect(page).to have_content(review2.content)

    page.has_css?("img[src*='https://via.placeholder.com/150']")
    expect(page).to have_content(review3.title)
    expect(page).to have_content(review3.rating)
    expect(page).to have_content(review3.content)
  end
end

#controller

  # def edit
  #   @review = Review.find(params[:id])
  # end

  # def update
  #   @review = Review.find(params[:id])
  #   @review.update(review_params)

  #   redirect_to "/shelters/#{shelter.id}/reviews/#{@review.id}"
  # end

  # def review_params
  #   params_permit(:review_image, :title, :rating, :content) #make content optional as well...
  # end

# View
# <h2>Edit Review</h2>
# <section>
#   <%= form_tag("/shelters/#{@shelter.id}/reviews/#{review.id}", method: :patch)  do %>

#     <%= label_tag "Title" %>
#     <%= text_field_tag :title %><br/>
#     <%= label_tag "Rating" %>
#     <%= text_field_tag :rating %><br/>
#     <%= label_tag "Content" %>
#     <%= text_field_tag :content %><br/>
#     <%= label_tag "Image (optional)" %>
#     <%= text_field_tag :review_image %><br/>

#     <%= submit_tag "Submit Review" %>
#   <% end %>
# </section>
