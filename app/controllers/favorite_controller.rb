class FavoriteController < ApplicationController

  def create
    pet = Pet.find(params[:pet_id])
    favorite.add_pet(pet.id)
    session[:favorite] = @favorite.contents
    flash[:pet_fav] = "Pet added to favorites."
    redirect_to "/pets/#{pet.id}"
  end

  def update
    pet = Pet.find(params[:pet_id])
    favorite.remove_pet(pet.id)
    session[:favorite] = @favorite.contents
    flash[:pet_fav] = "Pet removed from favorites."
    # redirect_to or render?
  end

  def destroy
    favorite.remove_all_pets
  end
end
