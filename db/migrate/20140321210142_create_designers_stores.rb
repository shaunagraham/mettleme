class CreateDesignersStores < ActiveRecord::Migration
   def change
    create_table :designers_stores do |t|
      t.integer :designer_id
      t.integer :store_id
      #t.timestamps
    end
  end
end
