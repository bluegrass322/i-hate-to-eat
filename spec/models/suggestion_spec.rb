# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Suggestion, type: :model do
  it "factoryがvalidなインスタンスを生成すること" do
    expect(build(:suggestion)).to be_valid
  end

  describe "amount" do
    context "正常系" do
      context "少数の場合" do
        it "validになること" do
          suggestion = build(:suggestion, amount: 0.1)
          suggestion.valid?

          expect(suggestion).to be_valid
          expect(suggestion.errors).to be_empty
        end
      end

      context "整数の場合" do
        it "validになること" do
          suggestion = build(:suggestion, amount: 2)
          suggestion.valid?

          expect(suggestion).to be_valid
          expect(suggestion.errors).to be_empty
        end
      end
    end

    context "異常系" do
      context "nilの場合" do
        it "invalidになること" do
          suggestion = build(:suggestion, amount: nil)
          suggestion.valid?

          expect(suggestion).to be_invalid
          expect(suggestion.errors[:amount]).to include "を入力してください"
        end
      end

      context "数値でない場合" do
        it "値が0.0になること" do
          suggestion = build(:suggestion, amount: "string")
          suggestion.valid?

          expect(suggestion.amount).to eq 0.0
        end
      end
    end
  end

  describe "expires_at" do
    context "異常系" do
      context "nilの場合" do
        it "invalidになること" do
          suggestion = build(:suggestion, expires_at: nil)
          suggestion.valid?
      
          expect(suggestion).to be_invalid
          expect(suggestion.errors[:expires_at]).to include "を入力してください"
        end
      end

      context "Timeオブジェクトでない場合" do
        it "invalidになること" do
          suggestion = build(:suggestion, expires_at: "string")
          suggestion.valid?
      
          expect(suggestion).to be_invalid
          expect(suggestion.errors[:expires_at]).to include "を入力してください"
        end
      end
    end
  end

  describe "target_date" do
    context "異常系" do
      context "nilの場合" do
        it "invalidになること" do
          suggestion = build(:suggestion, target_date: nil)
          suggestion.valid?
      
          expect(suggestion).to be_invalid
          expect(suggestion.errors[:target_date]).to include "を入力してください"
        end
      end

      context "Timeオブジェクトでない場合" do
        it "invalidになること" do
          suggestion = build(:suggestion, target_date: "string")
          suggestion.valid?
      
          expect(suggestion).to be_invalid
          expect(suggestion.errors[:target_date]).to include "を入力してください"
        end
      end
    end
  end
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
