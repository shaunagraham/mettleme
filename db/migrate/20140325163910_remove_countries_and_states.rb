class RemoveCountriesAndStates < ActiveRecord::Migration
  def up
    drop_table :countries
    drop_table :states
  end

  def down
  end
end
