class CreateMaterialsProducts < ActiveRecord::Migration
  def change
    create_table :materials_products do |t|
      t.integer :material_id
      t.integer :product_id
      #t.timestamps
    end
  end
end
