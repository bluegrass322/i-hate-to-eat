# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

# == Schema Information
#
# Table name: users
#
#  id               :bigint           not null, primary key
#  birth            :date
#  bmr              :float            default(0.0), not null
#  crypted_password :string
#  email            :string           default("address@example.com"), not null
#  gender           :integer          default("female"), not null
#  height           :integer          default(0), not null
#  name             :string           default("noname"), not null
#  role             :integer          default("general"), not null
#  salt             :string
#  weight           :float            default(0.0), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
