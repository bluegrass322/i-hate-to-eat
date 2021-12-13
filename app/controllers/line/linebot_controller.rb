module Line
  class LinebotController < Line::BaseController
    # LINEからのPOSTはprotect_from_forgeryを通過できない
    protect_from_forgery except: :callback

    include MealRecordCreatable
    include SuggestionsDestroyable

    def callback
      # 送られてきたデータをrubyが扱いやすいよう変換
      events = client.parse_events_from(@body)

      # 複数同時に送られてくる可能性のあるイベントたちを1つずつ処理
      events.each do |event|
        case event
        when Line::Bot::Event::AccountLink
          message = if event.result == "ok"
                      Line::AccountLinkingCompleter.call(event)
                    else
                      reply_text("アカウントの連携に失敗しました")
                    end
        when Line::Bot::Event::Follow
          message = if User.exists?(line_user_id: event["source"]["userId"])
                      reply_text("おかえりなさい")
                    else
                      Line::AccountLinkingUriCreater.call(client, event["source"]["userId"])
                    end
        when Line::Bot::Event::Message
          case event.type
          when Line::Bot::Event::MessageType::Text
            message = reply_to_text_message(event)
          end
        end
        client.reply_message(event['replyToken'], message) if message
      end

      # 200status は必ず返さなければならない
      head :ok
    end

    private

      # Event::Messageのテキストの内容により処理を振り分ける
      def reply_to_text_message(event)
        user = User.find_by(line_user_id: event["source"]["userId"])
        return reply_text("ユーザーの取得に失敗しました") unless user

        case event.message["text"]
        when "アカウント連携解除"
          Line::AccountLinkingRemover.call(user)
        when "BMR確認"
          Line::BmrAndPfcReplier.call(user)
        when "今日の食材"
          Line::SuggestionsReplier.call(user)
        when "食べない"
          donot_eat_meals(user)
        when "食べる"
          eat_meals(user)
        when "健康貯金"
          Line::HealthSavingsReplier.call(user)
        else
          # 所定の文言以外にはエラーメッセージを返す
          reply_text("ちょっと何言ってるかわからない")
        end
      end

      def donot_eat_meals(user)
        if destroy_suggestions_all(user)
          reply_text("了解しました")
        else
          reply_text("提案の削除処理に失敗しました")
        end
      end

      def eat_meals(user)
        if make_record_from_suggestion(user)
          reply_text("素晴らしい")
        else
          reply_text("既に登録済みか、または何らかの原因により登録処理に失敗しました")
        end
      end

      def reply_text(text)
        { type: 'text', text: text }
      end
  end
end