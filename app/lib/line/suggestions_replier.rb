# frozen_string_literal: true

module Line
  class SuggestionsReplier < Line::LinebotBase
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
end
