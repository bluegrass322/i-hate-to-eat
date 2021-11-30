# frozen_string_literal: true

class DietaryReferenceIntake < ApplicationRecord
  # Association
  has_many :users, dependent: :nullify

  # Enum
  enum gender: { female: 0, male: 10 }

  # Scope
  scope :for_female, -> { where(gender: 'female') }
  scope :for_male, -> { where(gender: 'male') }

  # Validation
  with_options presence: true do
    validates :gender

    with_options numericality: true do
      validates :age_bottom
      validates :age_top
      validates :biotin
      validates :calcium
      validates :chromium
      validates :copper
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
      validates :selenium
      validates :upper_limit_calcium
      validates :upper_limit_chromium
      validates :upper_limit_copper
      validates :upper_limit_folate
      validates :upper_limit_iodine
      validates :upper_limit_iron
      validates :upper_limit_manganese
      validates :upper_limit_molybdenum
      validates :upper_limit_niacin
      validates :upper_limit_phosphorus
      validates :upper_limit_selenium
      validates :upper_limit_vitamin_a
      validates :upper_limit_vitamin_b6
      validates :upper_limit_vitamin_d
      validates :upper_limit_vitamin_e
      validates :upper_limit_zinc
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

  # Class method
  def self.for_eighteen_to_twentynine
    find_by(age_bottom: 18)
  end

  def self.for_thirty_to_fortynine
    find_by(age_bottom: 30)
  end

  def self.for_fifty_to_sixtyfour
    find_by(age_bottom: 50)
  end
end

# == Schema Information
#
# Table name: dietary_reference_intakes
#
#  id                     :bigint           not null, primary key
#  age_bottom             :integer          default(0), not null
#  age_top                :integer          default(0), not null
#  biotin                 :float            default(0.0), not null
#  calcium                :float            default(0.0), not null
#  chromium               :float            default(0.0), not null
#  copper                 :float            default(0.0), not null
#  folate                 :float            default(0.0), not null
#  gender                 :integer          default("female"), not null
#  iodine                 :float            default(0.0), not null
#  iron                   :float            default(0.0), not null
#  magnesium              :float            default(0.0), not null
#  manganese              :float            default(0.0), not null
#  molybdenum             :float            default(0.0), not null
#  niacin                 :float            default(0.0), not null
#  pantothenic_acid       :float            default(0.0), not null
#  phosphorus             :float            default(0.0), not null
#  potassium              :float            default(0.0), not null
#  selenium               :float            default(0.0), not null
#  upper_limit_calcium    :float            default(0.0), not null
#  upper_limit_chromium   :float            default(0.0), not null
#  upper_limit_copper     :float            default(0.0), not null
#  upper_limit_folate     :float            default(0.0), not null
#  upper_limit_iodine     :float            default(0.0), not null
#  upper_limit_iron       :float            default(0.0), not null
#  upper_limit_manganese  :float            default(0.0), not null
#  upper_limit_molybdenum :float            default(0.0), not null
#  upper_limit_niacin     :float            default(0.0), not null
#  upper_limit_phosphorus :float            default(0.0), not null
#  upper_limit_selenium   :float            default(0.0), not null
#  upper_limit_vitamin_a  :float            default(0.0), not null
#  upper_limit_vitamin_b6 :float            default(0.0), not null
#  upper_limit_vitamin_d  :float            default(0.0), not null
#  upper_limit_vitamin_e  :float            default(0.0), not null
#  upper_limit_zinc       :float            default(0.0), not null
#  vitamin_a              :float            default(0.0), not null
#  vitamin_b1             :float            default(0.0), not null
#  vitamin_b12            :float            default(0.0), not null
#  vitamin_b2             :float            default(0.0), not null
#  vitamin_b6             :float            default(0.0), not null
#  vitamin_c              :float            default(0.0), not null
#  vitamin_d              :float            default(0.0), not null
#  vitamin_e              :float            default(0.0), not null
#  vitamin_k              :float            default(0.0), not null
#  zinc                   :float            default(0.0), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
