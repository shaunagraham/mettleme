class AddNumberInStockToProducts < ActiveRecord::Migration
  def change
    add_column :products, :number_in_stock, :integer
  end
end
