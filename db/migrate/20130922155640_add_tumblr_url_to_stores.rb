class AddTumblrUrlToStores < ActiveRecord::Migration
  def change
    add_column :stores, :tumblr_url, :string
  end
end
