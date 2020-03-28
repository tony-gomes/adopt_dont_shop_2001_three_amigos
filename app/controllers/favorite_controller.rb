class FavoriteController < ApplicationController

  def index
    @favorited = favorite.contents.map do |id|
      Pet.find(id)
    end
  end

  def update
    pet = Pet.find(params[:pet_id])
    favorite.add_pet(pet.id)
    session[:favorite] = @favorite.contents
    flash[:pet_fav] = "Pet added to favorites."
    redirect_to "/pets/#{pet.id}"
  end

  def destroy
    pet = Pet.find(params[:pet_id])
    favorite.remove_pet(pet.id)
    session[:favorite] = @favorite.contents
    flash[:pet_fav_remove] = "Pet removed from favorites."
    redirect_back(fallback_location: root_path)
  end
end
