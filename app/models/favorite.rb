class Favorite
  attr_reader :contents

  def initialize(initial_contents = Array.new)
    @contents = initial_contents || Array.new
  end

  def total_count
    @contents.length
  end

  def add_pet(id)
   @contents.push(id) unless @contents.include?(id)
  end

  def remove_pet(id)
   @contents.delete(id) if @contents.include?(id)
  end

  def remove_all_pets
    @contents.clear
  end
end
