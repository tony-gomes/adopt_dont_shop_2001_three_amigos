class FavoritesController < ApplicationController

  def index
    @favorited = favorite.contents.map do |id|
      Pet.find(id)
    end
    @pending_pets = Pet.where(adopt_status: "Pending")
    @submitted_pets = Pet.where(adopt_status: "Application Submitted")
  end

  def create
    pet = Pet.find(params[:pet_id])
    favorite.add_pet(pet.id)
    session[:favorite] = @favorite.contents
    flash[:success] = "Pet added to favorites."
    redirect_to "/pets/#{pet.id}"
  end

  def new
  end

  def update
    pet = Pet.find(params[:pet_id])
    favorite.remove_pet(pet.id)
    session[:favorite] = @favorite.contents
    flash[:notice] = "Pet removed from favorites."
    redirect_back(fallback_location: root_path)
  end

  def destroy
    favorite.remove_all_pets
    redirect_back(fallback_location: root_path)
  end

end
