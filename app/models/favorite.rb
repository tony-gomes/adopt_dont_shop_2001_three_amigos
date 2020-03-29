class Favorite
  attr_reader :contents

  def initialize(initial_contents = Array.new)
    @contents = initial_contents || Array.new
  end

  def total_count
    @contents.length
  end

  def check_pet(pet_id)
    @contents.include?(pet_id)
  end

  def load_favorite_pets
    @contents.map do |id|
      Pet.find(id)
    end
  end

  def add_pet(pet_id)
   @contents.push(pet_id) unless @contents.include?(pet_id)
  end

  def remove_pet(pet_id)
   @contents.delete(pet_id) if @contents.include?(pet_id)
  end

  def remove_all_pets
    @contents.clear
  end
end
