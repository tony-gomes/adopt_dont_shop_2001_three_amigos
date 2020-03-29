class RemoveColumnFromApplicationPets < ActiveRecord::Migration[5.1]
  def change
    remove_column :application_pets, :application_id, :string
  end
end
