class PetApplicationsController < ApplicationController

  def new
    @favorite_pets = favorite.load_favorite_pets
  end

  def show
    @pet_application = PetApplication.find(params[:id])
  end

  def create
    new_application = PetApplication.new(application_params)
    new_application.save
    pets = params[:pet_id]
    if new_application.save
      pets.each do |pet_id|
        ApplicationPet.create(pet_id: pet_id, pet_application_id: new_application.id)
        pet = Pet.find(pet_id)
        pet.update(adopt_status: "Pending")
        favorite.contents.delete(pet_id.to_i)
      end
      flash[:success] = "Your application was submitted successfully!"
      redirect_to "/favorites"
    else
      flash[:error] = "You must fill out all all of the application before it can be submitted."
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def application_params
    params.permit(:pet_id, :name, :address, :city,
      :state, :zip, :phone_number, :description)
  end

end
