class AddAttributesToPets < ActiveRecord::Migration[5.1]
  def change
    add_column :pets, :sex, :string
    add_column :pets, :shelter_id, :integer
  end
end
