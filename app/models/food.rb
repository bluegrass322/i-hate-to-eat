# frozen_string_literal: true

class Food < ApplicationRecord
  # Association
  belongs_to :food_category
  has_many :suggestions, dependent: :destroy
  has_many :eaten_foods, dependent: :destroy

  # Scope
  scope :prio_h, -> { where(priority: 15) }
  scope :prio_m, -> { where(priority: 10) }
  scope :prio_r, -> { where(priority: 5) }
  scope :prio_rm, -> { where(priority: 5..10) }
  scope :maindish, -> { joins(:food_category).merge(FoodCategory.main_cate) }
  scope :sidedish, -> { joins(:food_category).merge(FoodCategory.side_cate) }

  # Validation
  with_options presence: true do
    validates :name, length: { maximum: 30 }

    with_options numericality: true do
      validates :priority
      validates :reference_amount
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
  end
  validates :subname, length: { maximum: 30 }
  validates :description, length: { maximum: 400 }
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
