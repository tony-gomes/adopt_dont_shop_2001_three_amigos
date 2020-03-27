require 'rails_helper'

RSpec.describe Favorite do
  describe "#total_count" do
    it "can calculate the total number of items it holds" do
      favorite = Favorite.new([1,2,3,4,5])

      expect(favorite.total_count).to eq(5)
    end
  end

  describe "#add_pet" do
    it "adds the pet ID to the contents" do
      favorite = Favorite.new([1,2,3,4,5])

      favorite.add_pet(6)
      favorite.add_pet(7)

      expect(favorite.contents).to eq([1,2,3,4,5,6,7])
    end
  end
end
