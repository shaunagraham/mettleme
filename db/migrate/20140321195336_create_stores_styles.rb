class CreateStoresStyles < ActiveRecord::Migration
   def change
    create_table :stores_styles do |t|
      t.integer :store_id
      t.integer :style_id
      #t.timestamps
    end
  end
end
