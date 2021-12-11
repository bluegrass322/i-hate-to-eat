# frozen_string_literal: true

class LinebotBase
  require 'line/bot'

  # 汎用：テキストメッセージの作成
  def reply_text(text)
    { type: 'text', text: text }
  end
end
