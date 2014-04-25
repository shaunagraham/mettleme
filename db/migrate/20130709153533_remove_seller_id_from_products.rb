class RemoveSellerIdFromProducts < ActiveRecord::Migration
  def up
    remove_column :products, :seller_id
  end

  def down
    add_column :products, :seller_id, :integer
  end
end
