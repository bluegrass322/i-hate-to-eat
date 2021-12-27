# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EatenFood, type: :model do
  it "factoryがvalidなインスタンスを生成すること" do
    expect(build(:eaten_food)).to be_valid
  end

  describe "amount" do
    context "正常系" do
      context "少数の場合" do
        it "validになること" do
          eaten_food = build(:eaten_food, amount: 0.1)
          eaten_food.valid?

          expect(eaten_food).to be_valid
          expect(eaten_food.errors).to be_empty
        end
      end

      context "整数の場合" do
        it "validになること" do
          eaten_food = build(:eaten_food, amount: 2)
          eaten_food.valid?

          expect(eaten_food).to be_valid
          expect(eaten_food.errors).to be_empty
        end
      end
    end

    context "異常系" do
      context "nilの場合" do
        it "invalidになること" do
          eaten_food = build(:eaten_food, amount: nil)
          eaten_food.valid?

          expect(eaten_food).to be_invalid
          expect(eaten_food.errors[:amount]).to include "を入力してください"
        end
      end

      context "数値でない場合" do
        it "値が0.0になること" do
          eaten_food = build(:eaten_food, amount: "string")
          eaten_food.valid?

          expect(eaten_food.amount).to eq 0.0
        end
      end
    end
  end

  describe "meal_record_id" do
    let(:user) { create(:user) }

    context "正常系" do
      context "同一のmeal_recordに対し異なるfood_idを与えた場合" do
        it "vaidになること" do
          record = create(:meal_record, user_id: user.id, ate_at: Time.current)

          first_food = create(:food)
          create(:eaten_food, meal_record_id: record.id, food_id: first_food.id)

          second_food = create(:food)
          eaten_food = create(:eaten_food, meal_record_id: record.id, food_id: second_food.id)
          eaten_food.valid?

          expect(eaten_food).to be_valid
          expect(eaten_food.errors).to be_empty
        end
      end

      context "異なるmeal_recordに対し同じfood_idを与えた場合" do
        it "vaidになること" do
          food = create(:food)

          first_record = create(:meal_record, user_id: user.id, ate_at: Time.current.ago(1.day))
          create(:eaten_food, meal_record_id: first_record.id, food_id: food.id)

          second_record = create(:meal_record, user_id: user.id, ate_at: Time.current)
          eaten_food = create(:eaten_food, meal_record_id: second_record.id, food_id: food.id)
          eaten_food.valid?

          expect(eaten_food).to be_valid
          expect(eaten_food.errors).to be_empty
        end
      end
    end

    context "異常系" do
      context "nilの場合" do
        it "invaidになること" do
          food = create(:food)

          eaten_food = build(:eaten_food, meal_record_id: nil, food_id: food.id)
          eaten_food.valid?

          expect(eaten_food).to be_invalid
          expect(eaten_food.errors[:meal_record]).to include "を入力してください"
        end
      end

      context "同一のmeal_recordに対し同じfood_idを2度与えた場合" do
        it "invaidになること" do
          record = create(:meal_record)

          food = create(:food)
          create(:eaten_food, meal_record_id: record.id, food_id: food.id)

          eaten_food = build(:eaten_food, meal_record_id: record.id, food_id: food.id)
          eaten_food.valid?

          expect(eaten_food).to be_invalid
          expect(eaten_food.errors[:meal_record_id]).to include "はすでに存在します"
        end
      end
    end
  end
end

# == Schema Information
#
# Table name: eaten_foods
#
#  id             :bigint           not null, primary key
#  amount         :float            default(1.0), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  food_id        :bigint           not null
#  meal_record_id :bigint           not null
#
# Indexes
#
#  index_eaten_foods_on_food_id                     (food_id)
#  index_eaten_foods_on_meal_record_id              (meal_record_id)
#  index_eaten_foods_on_meal_record_id_and_food_id  (meal_record_id,food_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (food_id => foods.id)
#  fk_rails_...  (meal_record_id => meal_records.id)
#
