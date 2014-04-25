class AddPintrestUrlToStores < ActiveRecord::Migration
  def change
    add_column :stores, :pinterest_url, :string
  end
end
