class ChangeApplicationsPetsToApplicationPets < ActiveRecord::Migration[5.1]
  def change
    rename_table :applications_pets, :application_pets
  end
end
