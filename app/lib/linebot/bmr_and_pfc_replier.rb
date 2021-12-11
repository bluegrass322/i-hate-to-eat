# frozen_string_literal: true

require './app/lib/linebot/linebot_base'

class BmrAndPfcReplier < LinebotBase
  def self.call(user)
    new(user).call
  end

  def call
    amount = bmr_and_pfc_amount
    text = textualize(amount)

    reply_text(text)
  end

  private

    def initialize(user)
      @user = user
    end

    def bmr_and_pfc_amount
      @user.attributes_pfc[:amt]
    end

    def textualize(amount)
      "#{@user.name}さん \n\n" \
        "BMR: #{@user.bmr}kcal \n" \
        "P: #{amount[:protein]}g \n" \
        "F: #{amount[:fat]}g \n" \
        "C: #{amount[:carbohydrate]}g"
    end
end
