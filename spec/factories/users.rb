# frozen_string_literal: true

FactoryBot.define do
  factory :user do
  end
end

# == Schema Information
#
# Table name: users
#
#  id                          :bigint           not null, primary key
#  birth                       :date
#  bmr                         :float            default(0.0), not null
#  crypted_password            :string
#  email                       :string           default("address@example.com"), not null
#  gender                      :integer          default("female"), not null
#  height                      :integer          default(0), not null
#  name                        :string           default("noname"), not null
#  percentage_carbohydrate     :float            default(0.6), not null
#  percentage_fat              :float            default(0.2), not null
#  percentage_protein          :float            default(0.2), not null
#  role                        :integer          default("general"), not null
#  salt                        :string
#  weight                      :float            default(0.0), not null
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  dietary_reference_intake_id :bigint           default(0), not null
#
# Indexes
#
#  index_users_on_dietary_reference_intake_id  (dietary_reference_intake_id)
#  index_users_on_email                        (email) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (dietary_reference_intake_id => dietary_reference_intakes.id)
#
