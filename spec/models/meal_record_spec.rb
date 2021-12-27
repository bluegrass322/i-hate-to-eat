# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MealRecord, type: :model do
  it "factoryがvalidなインスタンスを生成すること" do
    expect(build(:meal_record)).to be_valid
  end

  describe "ate_at" do
    let(:user) { create(:user) }

    context "正常系" do
      context "同一ユーザーに異なる日付の場合" do
        it "vaidになること" do
          other_record = create(:meal_record, user_id: user.id, ate_at: Time.current.ago(1.day))

          record = build(:meal_record, user_id: user.id, ate_at: Time.current)
          record.valid?

          expect(record).to be_valid
          expect(user.errors).to be_empty
        end
      end

      context "異なるユーザーに重複した日付の場合" do
        it "vaidになること" do
          other_user = create(:user)
          other_record = create(:meal_record, user_id: other_user.id, ate_at: Time.current)

          record = build(:meal_record, user_id: user.id, ate_at: Time.current)
          record.valid?

          expect(record).to be_valid
          expect(user.errors).to be_empty
        end
      end
    end

    context "異常系" do
      context "nilの場合" do
        it "invaidになること" do
          record = build(:meal_record, user_id: user.id, ate_at: nil)
          record.valid?

          expect(record).to be_invalid
          expect(record.errors[:ate_at]).to include "を入力してください"
        end
      end

      context "同一ユーザーに重複した日付の場合" do
        it "invaidになること" do
          other_record = create(:meal_record, user_id: user.id, ate_at: Time.current)

          record = build(:meal_record, user_id: user.id, ate_at: Time.current)
          record.valid?

          expect(record).to be_invalid
          expect(record.errors[:ate_at]).to include "はすでに存在します"
        end
      end
    end
  end
end

# == Schema Information
#
# Table name: meal_records
#
#  id               :bigint           not null, primary key
#  ate_at           :date             not null
#  biotin           :float            default(0.0), not null
#  calcium          :float            default(0.0), not null
#  calorie          :float            default(0.0), not null
#  carbohydrate     :float            default(0.0), not null
#  chromium         :float            default(0.0), not null
#  copper           :float            default(0.0), not null
#  fat              :float            default(0.0), not null
#  folate           :float            default(0.0), not null
#  iodine           :float            default(0.0), not null
#  iron             :float            default(0.0), not null
#  magnesium        :float            default(0.0), not null
#  manganese        :float            default(0.0), not null
#  molybdenum       :float            default(0.0), not null
#  niacin           :float            default(0.0), not null
#  pantothenic_acid :float            default(0.0), not null
#  phosphorus       :float            default(0.0), not null
#  potassium        :float            default(0.0), not null
#  protein          :float            default(0.0), not null
#  selenium         :float            default(0.0), not null
#  vitamin_a        :float            default(0.0), not null
#  vitamin_b1       :float            default(0.0), not null
#  vitamin_b12      :float            default(0.0), not null
#  vitamin_b2       :float            default(0.0), not null
#  vitamin_b6       :float            default(0.0), not null
#  vitamin_c        :float            default(0.0), not null
#  vitamin_d        :float            default(0.0), not null
#  vitamin_e        :float            default(0.0), not null
#  vitamin_k        :float            default(0.0), not null
#  zinc             :float            default(0.0), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  user_id          :bigint           not null
#
# Indexes
#
#  index_meal_records_on_user_id             (user_id)
#  index_meal_records_on_user_id_and_ate_at  (user_id,ate_at) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
