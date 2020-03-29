class PetApplicationsController < ApplicationController

  def new
    @favorite_pets = favorite.load_favorite_pets
  end

  def create
    pets = params[:pet_id]
    new_application = PetApplication.new(application_params)
    binding.pry
    if new_application.save
      #flash[:confirmation] = ""
      redirect_to "/favorites"
    else
      redirect_back(fallback_location: root_path)
      flash[:error] = "Application must include a name, address, and content to be submitted."
    end
  end

  private

  def application_params
    params.permit(:pet_id, :name, :address, :city,
      :state, :zip, :phone_number, :description)
  end

end
