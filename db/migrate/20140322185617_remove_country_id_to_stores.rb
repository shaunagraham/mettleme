class RemoveCountryIdToStores < ActiveRecord::Migration
  def self.up
    remove_column :stores, :country_id
  end

  def self.down
    add_column :stores, :country_id, :integer
  end
end
