# frozen_string_literal: true

class FoodCategory < ApplicationRecord
  # Association
  has_many :foods, dependent: :destroy

  # Scope
  MAINDISHES = %w[魚介類 肉].freeze
  SIDEDISHES = %w[穀物 いも・でん粉 砂糖・甘味 豆 種実 野菜 果実 きのこ 藻].freeze

  scope :main_cate, -> { where(name: MAINDISHES) }
  scope :side_cate, -> { where(name: SIDEDISHES) }

  # Validation
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
