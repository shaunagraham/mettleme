class AddAdditionalDetailsToProducts < ActiveRecord::Migration
  def change
    add_column :products, :additional_details, :text
  end
end
