class AddSomeColumnsForPfcToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :percentage_protein, :float, null: false, default: 0.2
    add_column :users, :percentage_fat, :float, null: false, default: 0.2
    add_column :users, :percentage_carbohydrate, :float, null: false, default: 0.6
  end
end
