require 'rails_helper'

describe Shelter, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip }
  end

  describe "relationships" do
    it { should have_many :pets }
  end
end

RSpec.describe "#number_of_pets" do
    it "returns the number of pets at a shelter" do

      shelter_1 = Shelter.create(name: "Dog-Haven",
                                 address:  "1234 Barkers Way",
                                 city: "Beagle",
                                 state: "MA",
                                 zip: "01001")

      pet_1 = shelter_1.pets.create!(name: "Charlotte",
                                     age: 13,
                                     sex: "Female",
                                     image: "https://raw.githubusercontent.com/mikez321/adopt_dont_shop_2001/master/app/assets/images/charlotte.jpg")

      pet_2 = shelter_1.pets.create!(name: "Sydney",
                                     age: 13,
                                     sex: "Female",
                                     image: "https://raw.githubusercontent.com/mikez321/adopt_dont_shop_2001/master/app/assets/images/sydney.jpg")

      expect(shelter_1.number_of_pets).to eq(2)

    end

  describe "#average_rating" do
    it "averages all the ratings of a shelter" do
      shelter_1 = Shelter.create(name: "Dog-Haven",
                               address:  "1234 Barkers Way",
                               city: "Beagle",
                               state: "MA",
                               zip: "01001")

      review_1 = shelter_1.reviews.create!(review_image: "https://via.placeholder.com/150",
                                         title: "test review 1",
                                         rating: 3,
                                         content: "this review is average at best.")

      review_2 = shelter_1.reviews.create!(review_image: "https://via.placeholder.com/100",
                                         title: "test review 2",
                                         rating: 5,
                                         content: "this review is better than the last one.")

      expect(shelter_1.average_rating).to eq(4)
    end
  end
end
