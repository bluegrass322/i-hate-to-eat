# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Suggestion, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
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
