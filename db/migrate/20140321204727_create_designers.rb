class CreateDesigners < ActiveRecord::Migration
  def change
    create_table :designers do |t|
      t.string :name
      t.string :last_name
      t.boolean :top, :default => false

      t.timestamps
    end
  end
end
