require 'rails_helper'

RSpec.describe Favorite do
  describe "#total_count" do
    it "can calculate the total number of items it holds" do
      favorite = Favorite.new

      expect(favorite.total_count).to eq(0)
      expect(favorite.contents).to eq([])
    end
  end

  describe "#check_pet" do
    it "checks favorites for pet ID" do
      favorite = Favorite.new([1,2,3,4,5])

      expect(favorite.check_pet(3)).to eq(true)
      expect(favorite.check_pet(4)).to eq(true)
      expect(favorite.check_pet(7)).to eq(false)
    end
  end

  describe "#add_pet" do
    it "adds the pet ID to the contents" do
      favorite = Favorite.new([1,2,3,4,5])

      favorite.add_pet(6)
      favorite.add_pet(7)

      expect(favorite.total_count).to eq(7)
      expect(favorite.contents).to eq([1,2,3,4,5,6,7])
    end
  end

  describe "#load_favorite_pets" do
    it "returns the pet id for all favorited pets" do
      shelter_1 = Shelter.create(
        name: "Dog-Haven",
        address:  "1234 Barkers Way",
        city: "Beagle",
        state: "MA",
        zip: "01001")

      pet_1 = shelter_1.pets.create!(
        name: "Charlotte",
        age: 13,
        sex: "Female",
        image: "https://raw.githubusercontent.com/mikez321/adopt_dont_shop_2001/master/app/assets/images/charlotte.jpg")

      pet_2 = shelter_1.pets.create!(
        name: "Sydney",
        age: 13,
        sex: "Female",
        image: "https://raw.githubusercontent.com/mikez321/adopt_dont_shop_2001/master/app/assets/images/sydney.jpg")

      favorite = Favorite.new()

      expect(favorite.load_favorite_pets).to eq([])

      favorite.add_pet(pet_1.id)

      expect(favorite.load_favorite_pets).to eq([pet_1])
    end
  end

  describe "#remove_pet" do
    it "removes the pet ID to the contents" do
      favorite = Favorite.new([1,2,3,4,5])

      favorite.remove_pet(3)
      favorite.remove_pet(4)

      expect(favorite.total_count).to eq(3)
      expect(favorite.contents).to eq([1,2,5])
    end
  end

  describe "#remove_all_pets" do
    it "removes all pet IDs from contents" do
      favorite = Favorite.new([1,2,3,4,5])

      favorite.remove_all_pets

      expect(favorite.total_count).to eq(0)
      expect(favorite.contents).to eq([])
    end
  end
end
