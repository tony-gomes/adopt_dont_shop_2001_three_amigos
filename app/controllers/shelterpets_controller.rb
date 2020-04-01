class ShelterpetsController < ApplicationController

  def index
    @shelter = Shelter.find(params[:id])
  end

  def new
    @shelter = Shelter.find(params[:shelter_id])
  end

  def create
    shelter = Shelter.find(params[:shelter_id])
    pet = shelter.pets.new(pet_params)
    if pet.save
      redirect_to "/shelters/#{shelter.id}/pets"
    else
      flash[:error] = ""
      redirect_back(fallback_location: root_path)
      missing(pet_params).each do |param|
        flash[:error] += "The #{param} field must not be left blank. "
      end
      flash[:error]
    end
  end

  private

  def pet_params
    params.permit(:image, :name, :description, :age, :sex)
  end

  def missing(parameters)
    parameters.keys.find_all do |key|
      (key != "image" && key != "description" ) && params[key].empty?
    end
  end

end
