class RemoveUpdatedAtFromPets < ActiveRecord::Migration[5.1]
  def change
    remove_column :pets, :updated_at, :datetime
  end
end
