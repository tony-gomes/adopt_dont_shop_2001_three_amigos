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
    shelter = Shelter.new(shelter_params)
    if shelter.save
      redirect_to '/'
    else
      flash[:error] = ""
      redirect_back(fallback_location: root_path)
      missing(shelter_params).each do |param|
        flash[:error] += "The #{param} field must not be left blank. "
      end
      flash[:error]
    end
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
      pet.adopt_status != "Adoptable"
    end
  end

  def missing(parameters)
    parameters.keys.find_all do |key|
      params[key].empty?
    end
  end

end
