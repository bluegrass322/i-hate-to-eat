# frozen_string_literal: true

class User < ApplicationRecord
  authenticates_with_sorcery!

  # Associations
  belongs_to :dietary_reference_intake
  has_many :suggestions, dependent: :destroy
  has_many :suggested_foods, through: :suggestions, source: :food
  has_many :meal_records, dependent: :destroy

  # Scopes
  scope :linked_line, -> { where.not(line_user_id: nil) }
  scope :notice_enable, -> { where(line_notification_enabled: true) }
  scope :set_mealtime, -> { where.not(mealtime_first: nil) }
  scope :wish_line_notice, -> { linked_line.notice_enable.set_mealtime }

  # Encryption
  encrypts :email
  blind_index :email
  encrypts :line_user_id
  blind_index :line_user_id

  # Enums
  enum gender: { female: 0, male: 10 }
  enum role: { general: 0, admin: 10 }

  # Validations
  include ActiveModel::Validations
  validates_with PfcValidator

  with_options presence: true do
    validates :name, length: { maximum: 50 }, uniqueness: { case_sensitive: true }
    validates :email, uniqueness: { case_sensitive: false }
    validates :role
    validates :gender

    with_options numericality: { only_integer: true } do
      validates :height
      validates :health_savings
    end

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

  validates :line_user_id, uniqueness: { case_sensitive: true, allow_nil: true }
  validates :birth, birth: true
  validates :password, length: { minimum: 5 }, if: :new_or_changes_password
  validates :password, confirmation: true, if: :new_or_changes_password
  validates :password_confirmation, presence: true, if: :new_or_changes_password
  validates :line_notification_enabled, inclusion: { in: [true, false] }
  validates :mealtime_first, mealtime: true, allow_nil: true

  # Instance methods
  def calc_age
    (Time.zone.today.strftime("%Y%m%d").to_i - birth.strftime("%Y%m%d").to_i) / 10_000
  end

  def calc_bmr
    age = calc_age

    # 国立健康・栄養研究所の式（Ganpuleの式）を使用
    if gender == 'female'
      (0.0481 * weight + 0.0234 * height - 0.0138 * age - 0.9708) * 1000 / 4.186
    else
      (0.0481 * weight + 0.0234 * height - 0.0138 * age - 0.4235) * 1000 / 4.186
    end
  end

  def set_mypage_params
    {
      bmr_params: set_attributes_for_bmr,
      pfc_params: set_attributes_for_pfc,
      dri_params: dietary_reference_intake
    }
  end

  def set_account_params
    {
      name: name,
      email: email,
      line_notification_enabled: line_notification_enabled,
      mealtime_first: mealtime_first&.strftime('%R')
    }
  end

  def set_attributes_for_pfc
    { pct: { protein: percentage_protein,
             fat: percentage_fat,
             carbohydrate: percentage_carbohydrate },
      amt: { protein: calc_amount_protein.floor,
             fat: calc_amount_fat.floor,
             carbohydrate: calc_amount_carbo.floor } }
  end

  # LINE自動通知機能用
  # 当日の食事内容を送信（ボタンテンプレート）
  def set_line_notification_cofirm
    text = make_meal_menu_for_line
    set_temp_for_notice_sugegtions(text)
  end

  # LINE自動通知機能用
  # 1週間分のhealth_savinsを合算して送信
  def set_health_savings_this_week
    total = calc_health_savings_this_week
    { type: "text",
      text: "今週の健康貯金\n+ ¥#{total}" }
  end

  # LINE自動通知機能用
  # 当日の食事内容を送信（confirmなし）
  def make_meal_menu_for_line
    text = Time.zone.today.to_s
    total_cal = 0

    foods = suggested_foods
    foods.each do |f|
      text << "\n- #{f.name} #{f.subname}: #{(f.reference_amount * 100).floor}g"
      total_cal += (f.calorie * f.reference_amount).floor
    end
    text << "\n\n計 #{total_cal} / #{bmr.floor}kcal が摂取できます"
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

    def calc_health_savings_this_week
      records = meal_records.this_week
      total = 0
      return total if records.blank?

      records.each do |r|
        total += r.calorie
      end
      total.floor
    end

    def new_or_changes_password
      new_record? || changes[:crypted_password]
    end

    def set_attributes_for_bmr
      {
        gender: gender,
        birth: birth,
        height: height,
        weight: weight,
        bmr: bmr
      }
    end

    def set_temp_for_notice_sugegtions(text)
      {
        type: "template",
        altText: "本日の食事内容をお知らせします",
        template: {
          type: "buttons",
          text: text,
          actions: [
            {
              "type": "message",
              "label": "食べる",
              "text": "食べる"
            }
          ]
        }
      }
    end

    # def set_line_confirm_eat_or_not(text)
    #   {
    #     type: "template",
    #     altText: "本日の食事内容をお知らせします",
    #     template: {
    #       type: "confirm",
    #       text: text,
    #       actions: [
    #         { "type": "message", "label": "食べない", "text": "食べない" },
    #         { "type": "message", "label": "食べる", "text": "食べる" }
    #       ]
    #     }
    #   }
    # end
end

# == Schema Information
#
# Table name: users
#
#  id                          :bigint           not null, primary key
#  birth                       :date
#  bmr                         :float            default(0.0), not null
#  crypted_password            :string
#  email_bidx                  :string           not null
#  email_ciphertext            :text             not null
#  gender                      :integer          default("female"), not null
#  health_savings              :integer          default(0), not null
#  height                      :integer          default(0), not null
#  line_nonce                  :string
#  line_notification_enabled   :boolean          default(FALSE), not null
#  line_user_id_bidx           :string
#  line_user_id_ciphertext     :text
#  mealtime_first              :time
#  name                        :string           not null
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
#  index_users_on_email_bidx                   (email_bidx) UNIQUE
#  index_users_on_line_user_id_bidx            (line_user_id_bidx) UNIQUE
#  index_users_on_name                         (name) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (dietary_reference_intake_id => dietary_reference_intakes.id)
#
