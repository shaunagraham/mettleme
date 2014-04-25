class AddCountryAndStateToStores < ActiveRecord::Migration
  def change
    add_column :stores, :country, :string
    add_column :stores, :state, :string
  end
end
