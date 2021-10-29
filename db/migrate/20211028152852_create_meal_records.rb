class CreateMealRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :meal_records do |t|
      t.references :user, foreign_key: true, null:false

      t.float :calorie, null: false, default: 0
      t.float :protein, null: false, default: 0
      t.float :fat, null: false, default: 0
      t.float :carbohydrate, null: false, default: 0
      t.float :vitamin_a, null: false, default: 0
      t.float :vitamin_d, null: false, default: 0
      t.float :vitamin_e, null: false, default: 0
      t.float :vitamin_k, null: false, default: 0
      t.float :vitamin_b1, null: false, default: 0
      t.float :vitamin_b2, null: false, default: 0
      t.float :niacin, null: false, default: 0
      t.float :vitamin_b6, null: false, default: 0
      t.float :vitamin_b12, null: false, default: 0
      t.float :folate, null: false, default: 0
      t.float :pantothenic_acid, null: false, default: 0
      t.float :biotin, null: false, default: 0
      t.float :vitamin_c, null: false, default: 0
      t.float :potassium, null: false, default: 0
      t.float :calcium, null: false, default: 0
      t.float :magnesium, null: false, default: 0
      t.float :phosphorus, null: false, default: 0
      t.float :iron, null: false, default: 0
      t.float :zinc, null: false, default: 0
      t.float :copper, null: false, default: 0
      t.float :manganese, null: false, default: 0
      t.float :iodine, null: false, default: 0
      t.float :selenium, null: false, default: 0
      t.float :chromium, null: false, default: 0
      t.float :molybdenum, null: false, default: 0

      t.date :ate_at, null: false
      t.index [:user_id, :ate_at], unique: true

      t.timestamps
    end
  end
end
