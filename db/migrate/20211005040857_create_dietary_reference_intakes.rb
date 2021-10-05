class CreateDietaryReferenceIntakes < ActiveRecord::Migration[6.0]
  def change
    create_table :dietary_reference_intakes do |t|
      t.integer :gender, null: false, default: 0
      t.integer :age_top, null: false, default: 0
      t.integer :age_bottom, null: false, default: 0
      t.float :vitamin_a, null: false, default: 0.0
      t.float :upper_limit_vitamin_a, null: false, default: 0.0
      t.float :vitamin_d, null: false, default: 0.0
      t.float :upper_limit_vitamin_d, null: false, default: 0.0
      t.float :vitamin_e, null: false, default: 0.0
      t.float :upper_limit_vitamin_e, null: false, default: 0.0
      t.float :vitamin_k, null: false, default: 0.0
      t.float :vitamin_b1, null: false, default: 0.0
      t.float :vitamin_b2, null: false, default: 0.0
      t.float :niacin, null: false, default: 0.0
      t.float :upper_limit_niacin, null: false, default: 0.0
      t.float :vitamin_b6, null: false, default: 0.0
      t.float :upper_limit_vitamin_b6, null: false, default: 0.0
      t.float :vitamin_b12, null: false, default: 0.0
      t.float :folate, null: false, default: 0.0
      t.float :upper_limit_folate, null: false, default: 0.0
      t.float :pantothenic_acid, null: false, default: 0.0
      t.float :biotin, null: false, default: 0.0
      t.float :vitamin_c, null: false, default: 0.0
      t.float :potassium, null: false, default: 0.0
      t.float :calcium, null: false, default: 0.0
      t.float :upper_limit_calcium, null: false, default: 0.0
      t.float :magnesium, null: false, default: 0.0
      t.float :phosphorus, null: false, default: 0.0
      t.float :upper_limit_phosphorus, null: false, default: 0.0
      t.float :iron, null: false, default: 0.0
      t.float :upper_limit_iron, null: false, default: 0.0
      t.float :zinc, null: false, default: 0.0
      t.float :upper_limit_zinc, null: false, default: 0.0
      t.float :copper, null: false, default: 0.0
      t.float :upper_limit_copper, null: false, default: 0.0
      t.float :manganese, null: false, default: 0.0
      t.float :upper_limit_manganese, null: false, default: 0.0
      t.float :iodine, null: false, default: 0.0
      t.float :upper_limit_iodine, null: false, default: 0.0
      t.float :selenium, null: false, default: 0.0
      t.float :upper_limit_selenium, null: false, default: 0.0
      t.float :chromium, null: false, default: 0.0
      t.float :upper_limit_chromium, null: false, default: 0.0
      t.float :molybdenum, null: false, default: 0.0
      t.float :upper_limit_molybdenum, null: false, default: 0.0

      t.timestamps
    end
  end
end
