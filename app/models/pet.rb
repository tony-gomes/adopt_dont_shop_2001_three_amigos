class Pet < ApplicationRecord
  belongs_to :shelter
  has_many :application_pets
  has_many :pet_applications, through: :application_pets

  validates_presence_of :name, :age, :sex

end
