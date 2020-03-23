class AddAdoptableStatusToPets < ActiveRecord::Migration[5.1]
  def change
    add_column :pets, :adopt_status, :string
  end
end
