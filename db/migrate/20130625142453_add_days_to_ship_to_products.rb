class AddDaysToShipToProducts < ActiveRecord::Migration
  def change
    add_column :products, :days_to_ship, :integer
  end
end
