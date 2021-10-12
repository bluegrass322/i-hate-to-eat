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
        when Line::Bot::Event::Follow
          message = reply_confirm_linking_account
        when Line::Bot::Event::Message
          case event.type
          when Line::Bot::Event::MessageType::Text
            message = reply_text_message(event)
          end
        when Line::Bot::Event::Unfollow
          # rplyTokenは発行されない
          # 連携解除処理
        end
        client.reply_message(event['replyToken'], message)
      end

      # 200status は必ず返さなければならない
      head :ok
    end

    private

      def reply_confirm_linking_account
        {
          type: "template",
          altText: "LINEアカウントの連携をしてください",
          template: {
            type: "confirm",
            text: "LINEアカウントの連携をしてください。 \n" + "なお、連携の解除はいつでも行うことができます。",
            actions: [
              {
                type: "message",
                label: "Yes",
                text: "do linking"
              },
              {
                type: "message",
                label: "No",
                text: "don't linking"
              }
            ]
          }
        }
      end

      def reply_text_message(event)
        reply_text = case event.message["text"]
                     when "do linking"
                       set_url_for_linking(event["source"]["userId"])
                     when "don't linking"
                       "引き続きLINE通知以外の機能をご利用ください"
                     when "hi"
                       "Good morning!"
                     when "bye"
                       "Good bye!"
                     else
                       # 所定の文言以外にはエラーメッセージを返す
                       "ちょっと何言ってるかわからない"
                     end

        { type: 'text', text: reply_text }
      end

      def set_url_for_linking(line_id)
        # 連携手順1. 連携トークンを発行する
        token = require_link_token(line_id)

        # 連携手順2. ユーザーを連携URLにリダイレクトする
        {
          type: "template",
          altText: "アカウント連携用ページ",
          template: {
            type: "buttons",
            text: "以下のURLから再度ログインし、アカウント連携を行ってください",
            defaultAction: {
              type: "uri",
              label: "アカウント連携ページ",
              uri: "https://i-hate-to-eat.herokuapp.com/line/link?linkToken=#{ token['linkToken'] }"
            },
            actions: [
              {
                type: "uri",
                label: "アカウント連携ページ",
                uri: "https://i-hate-to-eat.herokuapp.com/line/link?linkToken=#{ token['linkToken'] }"
              }
            ]
          }
        }
      end

      def require_link_token(line_id)
        client = Line::Bot::Client.new{ |config|
          config.channel_secret = Rails.application.credentials.line[:CHANNEL_SECRET]
          config.channel_token = Rails.application.credentials.line[:CHANNEL_TOKEN]
        }
        client.create_link_token(line_id)
      end
  end
end
