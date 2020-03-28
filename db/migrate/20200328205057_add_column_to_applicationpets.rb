class AddColumnToApplicationpets < ActiveRecord::Migration[5.1]
  def change
    add_reference :application_pets, :pet_application, foreign_key: true
  end
end
