require 'rails_helper'

describe Pet, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :age }
    it { should validate_presence_of :sex }
  end

  describe "relationships" do
    it { should belong_to :shelter }
    it { should have_many(:application_pets) }
    it { should have_many(:pet_applications).through(:application_pets) }
  end
end
