class PetApplicationsController < ApplicationController

  def new
    @favorite_pets = favorite.load_favorite_pets
  end

end
