class ChangeApplicationsToPetApplications < ActiveRecord::Migration[5.1]
  def change
    rename_table :applications, :pet_applications
  end
end
