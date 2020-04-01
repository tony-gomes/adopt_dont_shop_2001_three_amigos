class Shelter < ApplicationRecord

  has_many :pets, :dependent => :destroy
  has_many :reviews, :dependent => :destroy

  validates_presence_of :name, :address, :city, :state, :zip


  def number_of_pets
    pets.length
  end

  def average_rating
    reviews.average(:rating)
  end

end
