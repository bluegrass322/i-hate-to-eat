# frozen_string_literal: true

class FoodCategory < ApplicationRecord
  # Associations
  has_many :foods, dependent: :destroy

  # Validations
  validates :name, presence: true
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
