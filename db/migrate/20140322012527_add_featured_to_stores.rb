class AddFeaturedToStores < ActiveRecord::Migration
  def change
    add_column :stores, :featured, :boolean, :default => false
  end
end
