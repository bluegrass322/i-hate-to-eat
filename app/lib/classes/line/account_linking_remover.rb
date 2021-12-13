# frozen_string_literal: true

require './app/lib/classes/line/linebot_base'

module Line
  class AccountLinkingRemover < Line::LinebotBase
    def self.call(user)
      new(user).call
    end

    def call
      remove_linking
      reply_text("LINEアカウントの連携を解除しました")
    end

    private

      def initialize(user)
        @user = user
      end

      def remove_linking
        @user.update!(line_user_id: nil)
      rescue StandardError => e
        Rails.logger.error "User#{@user.id}: Failed to remove account linking. Cause...'#{e}'"
        notice_to_admin("LINEアカウント連携解除に失敗")
      end
  end
end
