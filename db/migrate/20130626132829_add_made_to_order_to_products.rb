class AddMadeToOrderToProducts < ActiveRecord::Migration
  def change
    add_column :products, :made_to_order, :boolean
  end
end
