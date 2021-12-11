# frozen_string_literal: true

require './app/lib/linebot/linebot_base'

class SuggestionsReplier < LinebotBase
  def self.call(user)
    new(user).call
  end

  def call
    text = @user.make_meal_menu_for_line
    reply_text(text)
  end

  private

    def initialize(user)
      @user = user
    end
end
