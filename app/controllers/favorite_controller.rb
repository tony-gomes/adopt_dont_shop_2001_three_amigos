class FavoriteController < ApplicationController

  def update
    pet = Pet.find(params[:pet_id])
    favorite.add_pet(pet.id)
    session[:favorite] = @favorite.contents
    flash[:pet_fav] = "Pet added to favorites."
    redirect_to "/pets/#{pet.id}"
  end

end
