# frozen_string_literal: true

class MealRecord < ApplicationRecord
  # Associations
  belongs_to :user
  has_many :eaten_foods, dependent: :destroy
  has_many :recorded_foods, through: :eaten_foods, source: :food

  # Validations
  with_options presence: true do
    with_options numericality: true do
      validates :biotin
      validates :calcium
      validates :calorie
      validates :carbohydrate
      validates :chromium
      validates :copper
      validates :fat
      validates :folate
      validates :iodine
      validates :iron
      validates :magnesium
      validates :manganese
      validates :molybdenum
      validates :niacin
      validates :pantothenic_acid
      validates :phosphorus
      validates :potassium
      validates :protein
      validates :selenium
      validates :vitamin_a
      validates :vitamin_b1
      validates :vitamin_b12
      validates :vitamin_b2
      validates :vitamin_b6
      validates :vitamin_c
      validates :vitamin_d
      validates :vitamin_e
      validates :vitamin_k
      validates :zinc
    end
    validates :ate_at, uniqueness: { scope: [:user_id] }
  end
end

# == Schema Information
#
# Table name: meal_records
#
#  id               :bigint           not null, primary key
#  ate_at           :date             not null
#  biotin           :float            default(0.0), not null
#  calcium          :float            default(0.0), not null
#  calorie          :float            default(0.0), not null
#  carbohydrate     :float            default(0.0), not null
#  chromium         :float            default(0.0), not null
#  copper           :float            default(0.0), not null
#  fat              :float            default(0.0), not null
#  folate           :float            default(0.0), not null
#  iodine           :float            default(0.0), not null
#  iron             :float            default(0.0), not null
#  magnesium        :float            default(0.0), not null
#  manganese        :float            default(0.0), not null
#  molybdenum       :float            default(0.0), not null
#  niacin           :float            default(0.0), not null
#  pantothenic_acid :float            default(0.0), not null
#  phosphorus       :float            default(0.0), not null
#  potassium        :float            default(0.0), not null
#  protein          :float            default(0.0), not null
#  selenium         :float            default(0.0), not null
#  vitamin_a        :float            default(0.0), not null
#  vitamin_b1       :float            default(0.0), not null
#  vitamin_b12      :float            default(0.0), not null
#  vitamin_b2       :float            default(0.0), not null
#  vitamin_b6       :float            default(0.0), not null
#  vitamin_c        :float            default(0.0), not null
#  vitamin_d        :float            default(0.0), not null
#  vitamin_e        :float            default(0.0), not null
#  vitamin_k        :float            default(0.0), not null
#  zinc             :float            default(0.0), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  user_id          :bigint           not null
#
# Indexes
#
#  index_meal_records_on_user_id             (user_id)
#  index_meal_records_on_user_id_and_ate_at  (user_id,ate_at) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
