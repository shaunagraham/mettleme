class AddImageToStores < ActiveRecord::Migration
  def up
    add_attachment :stores, :image
  end
  
  def down
    remove_attachment :stores, :image
  end
end
