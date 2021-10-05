# frozen_string_literal: true

class DietaryReferenceIntakeSerializer
  include FastJsonapi::ObjectSerializer
  attributes :biotin, :calcium, :chromium, :copper, :folate, :iodine,
             :iron, :magnesium, :manganese, :molybdenum, :niacin,
             :pantothenic_acid, :phosphorus, :potassium, :selenium,
             :upper_limit_calcium, :upper_limit_chromium, :upper_limit_copper,
             :upper_limit_folate, :upper_limit_iodine, :upper_limit_iron,
             :upper_limit_manganese, :upper_limit_molybdenum, :upper_limit_niacin,
             :upper_limit_phosphorus, :upper_limit_selenium, :upper_limit_vitamin_a,
             :upper_limit_vitamin_b6, :upper_limit_vitamin_d, :upper_limit_vitamin_e,
             :upper_limit_zinc, :vitamin_a, :vitamin_b1, :vitamin_b12,
             :vitamin_b2, :vitamin_b6, :vitamin_c, :vitamin_d,
             :vitamin_e, :vitamin_k, :zinc

  has_many :users
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
