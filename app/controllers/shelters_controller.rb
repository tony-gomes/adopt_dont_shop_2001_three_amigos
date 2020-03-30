class SheltersController < ApplicationController

  def index
    @shelters = Shelter.all
  end

  def show
    @shelter = Shelter.find(params[:id])
    @num_pending_pets = pending_pets.length
  end

  def new
  end

  def create
    Shelter.create(shelter_params)
    redirect_to '/'
  end

  def destroy
    Shelter.destroy(params[:id])
    redirect_to '/'
  end

  def edit
    @shelter = Shelter.find(params[:id])
  end

  def update
    shelter = Shelter.find(params[:id])
    shelter.update(shelter_params)

    redirect_to "/shelters/#{shelter.id}/"
  end

  private
  def shelter_params
    params.permit(:name, :address, :city, :state, :zip)
  end

  def pending_pets
    @shelter.pets.find_all do |pet|
      pet.adopt_status == "Pending"
    end
  end

end
