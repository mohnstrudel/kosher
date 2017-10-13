class AddCitiesToSeos < ActiveRecord::Migration[5.1]
  def change
    add_reference :seos, :city, foreign_key: true
  end
end
