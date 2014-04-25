class CreateProductsStyles < ActiveRecord::Migration
  def change
    create_table :products_styles do |t|
      t.integer :product_id
      t.integer :style_id
      #t.timestamps
    end
  end
end
