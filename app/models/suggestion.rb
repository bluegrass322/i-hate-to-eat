# frozen_string_literal: true

class Suggestion < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :food

  # Validations
  with_options presence: true do
    validates :amount
    validates :target_date
    validates :expires_at
  end

  validates :user_id, uniqueness: { scope: [:food_id, :target_date] }
end

# == Schema Information
#
# Table name: suggestions
#
#  id          :bigint           not null, primary key
#  amount      :float            default(1.0), not null
#  expires_at  :datetime         not null
#  target_date :date             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  food_id     :bigint           not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_suggestions_on_food_id                              (food_id)
#  index_suggestions_on_user_id                              (user_id)
#  index_suggestions_on_user_id_and_food_id_and_target_date  (user_id,food_id,target_date) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (food_id => foods.id)
#  fk_rails_...  (user_id => users.id)
#
