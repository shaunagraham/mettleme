class AddFacebookUrlToStores < ActiveRecord::Migration
  def change
    add_column :stores, :facebook_url, :string
  end
end
