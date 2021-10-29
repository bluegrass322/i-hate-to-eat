class CreateEatenFoods < ActiveRecord::Migration[6.0]
  def change
    create_table :eaten_foods do |t|
      t.references :meal_records, foreign_key: true, null:false
      t.references :foods, foreign_key: true, null:false

      t.float :amount, null: false, default: 1.0

      t.timestamps
    end
  end
end
