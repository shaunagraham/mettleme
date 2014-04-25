class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.string :name
      t.string :owner_name
      t.integer :country_id
      t.integer :state_id
      t.string :city
      t.text :description

      t.timestamps
    end
  end
end
