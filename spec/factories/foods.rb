# frozen_string_literal: true

FactoryBot.define do
  factory :food do
  end
end

# == Schema Information
#
# Table name: foods
#
#  id               :bigint           not null, primary key
#  biotin           :float            default(0.0), not null
#  calcium          :float            default(0.0), not null
#  calorie          :float            default(0.0), not null
#  carbohydrate     :float            default(0.0), not null
#  chromium         :float            default(0.0), not null
#  copper           :float            default(0.0), not null
#  description      :text
#  fat              :float            default(0.0), not null
#  folate           :float            default(0.0), not null
#  iodine           :float            default(0.0), not null
#  iron             :float            default(0.0), not null
#  magnesium        :float            default(0.0), not null
#  manganese        :float            default(0.0), not null
#  molybdenum       :float            default(0.0), not null
#  name             :string           default("noname"), not null
#  niacin           :float            default(0.0), not null
#  pantothenic_acid :float            default(0.0), not null
#  phosphorus       :float            default(0.0), not null
#  potassium        :float            default(0.0), not null
#  priority         :integer          default(0), not null
#  protein          :float            default(0.0), not null
#  reference_amount :float            default(1.0), not null
#  selenium         :float            default(0.0), not null
#  subname          :string
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
#  food_category_id :bigint
#
# Indexes
#
#  index_foods_on_food_category_id  (food_category_id)
#
# Foreign Keys
#
#  fk_rails_...  (food_category_id => food_categories.id)
#
