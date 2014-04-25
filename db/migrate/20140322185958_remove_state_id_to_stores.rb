class RemoveStateIdToStores < ActiveRecord::Migration
  def self.up
    remove_column :stores, :state_id
  end

  def self.down
    add_column :stores, :state_id, :integer
  end
end
