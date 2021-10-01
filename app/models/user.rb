# frozen_string_literal: true

class User < ApplicationRecord
  # Enums
  enum role: { general: 0, admin: 10 }

  # Validations
  with_options presence: true do
    validates :name, length: { maximum: 50 }
    validates :email, uniqueness: { case_sensitive: false }
    validates :role
  end

  validates :password, length: { minimum: 5 }, if: :new_or_changes_password
  validates :password, confirmation: true, if: :new_or_changes_password
  validates :password_confirmation, presence: true, if: :new_or_changes_password
end

# == Schema Information
#
# Table name: users
#
#  id               :bigint           not null, primary key
#  crypted_password :string
#  email            :string           default("address@example.com"), not null
#  name             :string           default("noname"), not null
#  role             :integer          default("general"), not null
#  salt             :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
