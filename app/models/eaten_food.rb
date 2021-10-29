class EatenFood < ApplicationRecord
  # Validations
  validates :amount, presence: true, numericality: true
  validates :meal_records_id, uniqueness: { scope: [:foods_id] }
end

# == Schema Information
#
# Table name: eaten_foods
#
#  id              :bigint           not null, primary key
#  amount          :float            default(1.0), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  foods_id        :bigint           not null
#  meal_records_id :bigint           not null
#
# Indexes
#
#  index_eaten_foods_on_foods_id         (foods_id)
#  index_eaten_foods_on_meal_records_id  (meal_records_id)
#
# Foreign Keys
#
#  fk_rails_...  (foods_id => foods.id)
#  fk_rails_...  (meal_records_id => meal_records.id)
#
