class Favorite
  attr_reader :contents

  def initialize(initial_contents = Array.new)
    @contents = initial_contents || Array.new
  end

  def total_count
    @contents.length
  end

  def favorite_check(pet_id)
    @contents.include?(pet_id)
  end

  def add_pet(pet_id)
    if !@contents.include?(pet_id)
      @contents << pet_id
    end
  end

  def remove_pet(pet_id)
    if @contents.include?(pet_id)
      @contents.delete(pet_id)
    end
  end
end
