class MealRecord < ApplicationRecord
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
