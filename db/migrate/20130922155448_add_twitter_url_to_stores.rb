class AddTwitterUrlToStores < ActiveRecord::Migration
  def change
    add_column :stores, :twitter_url, :string
  end
end
