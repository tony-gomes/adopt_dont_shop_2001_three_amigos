class ChangeDefaultStatusFromPets < ActiveRecord::Migration[5.1]
  def change
    change_column_default :pets, :adopt_status, from:nil, to:"Adoptable"
  end
end
