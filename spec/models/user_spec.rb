# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

# == Schema Information
#
# Table name: users
#
#  id                           :bigint           not null, primary key
#  birth                        :date
#  bmr                          :float            default(0.0), not null
#  crypted_password             :string
#  email_bidx                   :string           not null
#  email_ciphertext             :text             not null
#  gender                       :integer          default("female"), not null
#  health_savings               :integer          default(0), not null
#  height                       :integer          default(0), not null
#  line_nonce                   :string
#  line_notification_enabled    :boolean          default(FALSE), not null
#  line_user_id_bidx            :string
#  line_user_id_ciphertext      :text
#  mealtime_first               :time
#  name                         :string           not null
#  percentage_carbohydrate      :float            default(0.6), not null
#  percentage_fat               :float            default(0.2), not null
#  percentage_protein           :float            default(0.2), not null
#  remember_me_token            :string
#  remember_me_token_expires_at :datetime
#  role                         :integer          default("general"), not null
#  salt                         :string
#  weight                       :float            default(0.0), not null
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  dietary_reference_intake_id  :bigint           default(0), not null
#
# Indexes
#
#  index_users_on_dietary_reference_intake_id  (dietary_reference_intake_id)
#  index_users_on_email_bidx                   (email_bidx) UNIQUE
#  index_users_on_line_user_id_bidx            (line_user_id_bidx) UNIQUE
#  index_users_on_name                         (name) UNIQUE
#  index_users_on_remember_me_token            (remember_me_token)
#
# Foreign Keys
#
#  fk_rails_...  (dietary_reference_intake_id => dietary_reference_intakes.id)
#
