class ReviewsController < ApplicationController

  def new
    @shelter = Shelter.find(params[:shelter_id])
  end

  def create
    shelter = Shelter.find(params[:shelter_id])
    shelter.reviews.create(review_params)
    if shelter.reviews.create(review_params).valid?
      redirect_to "/shelters/#{shelter.id}"
    else
      redirect_back(fallback_location: root_path)
      flash[:error] = "Review must include a title, rating, and content to be submitted."
    end
  end

  def edit
    @review = Review.find(params[:review_id])
  end

  def update
    @review = Review.find(params[:review_id])
    @review.update(review_params)
    redirect_to "/shelters/#{@review.shelter_id}"
  end

  private

  def review_params
    params.permit(:title, :rating, :content, :review_image)
  end
end
