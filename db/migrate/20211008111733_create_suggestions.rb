class CreateSuggestions < ActiveRecord::Migration[6.0]
  def change
    create_table :suggestions do |t|
      t.references :user, foreign_key: true, null: false
      t.references :food, foreign_key: true, null: false
      t.float :amount, null: false, default: 1.0
      t.date :target_date, null: false
      t.datetime :expires_at, null: false

      t.timestamps
    end

    add_index :suggestions, [:user_id, :food_id, :target_date], unique: true
  end
end
