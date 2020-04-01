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
    if @favorites != nil && @favorites.contents.include?(pet_id)
      @favorites.contents.delete(pet_id)
    end
    redirect_to "/pets"
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def update
    pet = Pet.find(params[:id])
    pet.update(pet_params)

    redirect_to "/pets/#{pet.id}"
  end

  private

  def pet_params
    params.permit(:image, :name, :description, :age, :sex)
  end

end
