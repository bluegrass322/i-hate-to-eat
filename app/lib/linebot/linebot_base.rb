# frozen_string_literal: true

class LinebotBase
  # 汎用：テキストメッセージの作成
  def reply_text(text)
    { type: 'text', text: text }
  end
end
