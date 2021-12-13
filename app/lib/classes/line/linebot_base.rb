# frozen_string_literal: true

module Line
  class LinebotBase
    include Common::NotificatableToAdmin

    # 汎用：テキストメッセージの作成
    def reply_text(text)
      { type: 'text', text: text }
    end
  end
end
