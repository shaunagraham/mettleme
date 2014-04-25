class CreateProductsSeasons < ActiveRecord::Migration
  def change
    create_table :products_seasons do |t|
      t.integer :product_id
      t.integer :season_id
      #t.timestamps
    end
  end
end
