class RemoveCreatedAtFromPets < ActiveRecord::Migration[5.1]
  def change
    remove_column :pets, :created_at, :datetime
  end
end
