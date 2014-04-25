class CreateFavourites < ActiveRecord::Migration
  def change
    create_table :favourites do |t|
      t.integer :user_id
      t.integer :favoured_id
      t.string :favoured_type

      t.timestamps
    end
  end
end
