class AddShelterIdToPets < ActiveRecord::Migration[5.1]
  def change
    add_column :pets, :shelter_id, :integer
  end
end
