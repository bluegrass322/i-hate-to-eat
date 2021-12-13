# frozen_string_literal: true

require "./app/lib/modules/common/notificatable_to_admin"

class LinebotBase
  include Common::NotificatableToAdmin

  # 汎用：テキストメッセージの作成
  def reply_text(text)
    { type: 'text', text: text }
  end
end
