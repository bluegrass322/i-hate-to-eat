class FoodCategory < ApplicationRecord
  # Validations
  validates :name, presence: true, uniqueness: true
end

# == Schema Information
#
# Table name: food_categories
#
#  id         :bigint           not null, primary key
#  name       :string           default("noname"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
