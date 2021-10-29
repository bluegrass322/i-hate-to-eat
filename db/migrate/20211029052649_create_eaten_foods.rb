class CreateEatenFoods < ActiveRecord::Migration[6.0]
  def change
    create_table :eaten_foods do |t|
      t.references :meal_record, foreign_key: true, null:false
      t.references :food, foreign_key: true, null:false

      t.float :amount, null: false, default: 1.0

      t.timestamps
    end
  end
end
