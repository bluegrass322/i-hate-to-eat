module Line
  class LinebotController < Line::BaseController
    # LINEからのPOSTはprotect_from_forgeryを通過できない
    protect_from_forgery except: :callback

    def callback
      # 送られてきたデータをrubyが扱いやすいよう変換
      events = client.parse_events_from(@body)

      # 複数同時に送られてくる可能性のあるイベントたちを1つずつ処理
      events.each do |event|
        case event
        when Line::Bot::Event::Message
          case event.type
          when Line::Bot::Event::MessageType::Text
            message = set_reply_message(event.message['text'])
            client.reply_message(event['replyToken'], message)
          end
        end
      end

      # 200status は必ず返さなければならない
      head :ok
    end

    private

      def set_reply_message(text)
        reply_text = case text
                     when "hi"
                       'Good morning!'
                     when "bye"
                       'Good bye!'
                     else
                       # 所定の文言以外にはエラーメッセージを返す
                       'ちょっと何言ってるかわかんない'
                     end

        return { type: 'text', text: reply_text }
      end
  end
end
