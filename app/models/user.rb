# frozen_string_literal: true

class User < ApplicationRecord
  authenticates_with_sorcery!

  # Associations
  belongs_to :dietary_reference_intake

  # Enums
  enum gender: { female: 0, male: 10 }
  enum role: { general: 0, admin: 10 }

  # Validations
  include ActiveModel::Validations
  validates_with PfcValidator

  with_options presence: true do
    validates :name, length: { maximum: 50 }
    validates :email, uniqueness: { case_sensitive: false }
    validates :role
    validates :gender
    validates :height, numericality: { only_integer: true }

    with_options numericality: true do
      validates :weight
      validates :bmr
    end

    with_options numericality: { greater_than_or_equal_to: 0.1, less_than_or_equal_to: 0.8 } do
      validates :percentage_protein
      validates :percentage_fat
      validates :percentage_carbohydrate
    end
  end

  validates :birth, birth: true
  validates :password, length: { minimum: 5 }, if: :new_or_changes_password
  validates :password, confirmation: true, if: :new_or_changes_password
  validates :password_confirmation, presence: true, if: :new_or_changes_password

  # Instance methods
  def calc_age
    (Time.zone.today.strftime("%Y%m%d").to_i - birth.strftime("%Y%m%d").to_i) / 10_000
  end

  def calc_bmr
    age = calc_age

    # 国立健康・栄養研究所の式（Ganpule の式）を使用
    if gender == 'female'
      (0.0481 * weight + 0.0234 * height - 0.0138 * age - 0.9708) * 1000 / 4.186
    else
      (0.0481 * weight + 0.0234 * height - 0.0138 * age - 0.4235) * 1000 / 4.186
    end
  end

  # TODO: コントローラーの整理後不要になるかも？
  def set_attributes_for_bmr
    {
      gender: gender,
      birth: birth,
      height: height,
      weight: weight,
      bmr: bmr
    }
  end

  def set_amount_pfc
    {
      protein: calc_amount_protein,
      fat: calc_amount_fat,
      carbohydrate: calc_amount_carbo
    }
  end

  private

    def calc_amount_protein
      bmr * percentage_protein / 4
    end

    def calc_amount_fat
      bmr * percentage_fat / 9
    end

    def calc_amount_carbo
      bmr * percentage_carbohydrate / 4
    end

    def new_or_changes_password
      new_record? || changes[:crypted_password]
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
