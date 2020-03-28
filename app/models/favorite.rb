class Favorite
  attr_reader :contents

  def initialize(initial_contents = Array.new)
    @contents = initial_contents 
  end

  def total_count
    @contents.length
  end

  def add_pet(id)
    if !@contents.include?(id)
      @contents << id
    end
  end

end
