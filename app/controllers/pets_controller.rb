class PetsController < ApplicationController

  def index
    @pets = Pet.all
    @favorite = Favorite.new(session[:favorite])
  end

  def show
    @pet = Pet.find(params[:id])
  end

  def destroy
    Pet.destroy(params[:id])
    pet_id = params[:id].to_i
    if favorite != nil && favorite.contents.include?(pet_id)
      favorite.contents.delete(pet_id)
    end
    redirect_to "/pets"
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def update
    pet = Pet.find(params[:id])
    if pet.update(pet_params)
      redirect_to "/pets/#{pet.id}"
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
