module Line
  class LinebotController < Line::BaseController
    # LINEからのPOSTはprotect_from_forgeryを通過できない
    protect_from_forgery except: :callback

    def callback
      # 送られてきたデータをrubyが扱いやすいよう変換
      events = client.parse_events_from(@body)

      # 複数同時に送られてくる可能性のあるイベントたちを1つずつ処理
      events.each do |event|
        # イベントの種類がMessageである場合（他には友達追加やブロックなど）
        case event
        when Line::Bot::Event::Message
          # メッセージの種類がテキストであるか画像であるか
          case event.type
          when Line::Bot::Event::MessageType::Text
            message = set_reply_message
            client.reply_message(event['replyToken'], message)
          when Line::Bot::Event::MessageType::Image, Line::Bot::Event::MessageType::Video
            response = client.get_message_content(event.message['id'])
            tf = Tempfile.open("content")
            tf.write(response.body)
          end
        end
      end

      # 200status は必ず返さなければならない
      head :ok
    end

    private

      def set_reply_message
        reply_text = case event.message['text']
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
