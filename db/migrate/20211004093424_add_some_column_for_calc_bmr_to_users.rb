class AddSomeColumnForCalcBmrToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :gender, :integer, null: false, default: 0
    add_column :users, :birth, :date
    add_column :users, :height, :integer, null: false, default: 0
    add_column :users, :weight, :float, null: false, default: 0.0
    add_column :users, :bmr, :float, null: false, default: 0.0
  end
end
