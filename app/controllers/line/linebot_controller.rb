module Line
  class LinebotController < Line::BaseController
    # LINEからのPOSTはprotect_from_forgeryを通過できない
    protect_from_forgery except: :callback

    Dir[Rails.root.join(".", "app", "lib", "linebot", "*")].each {|file| require_relative file }

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
                      complete_linking_account(event)
                    else
                      set_reply_text("アカウントの連携に失敗しました")
                    end
        when Line::Bot::Event::Follow
          message = reply_url_for_linking(event["source"]["userId"])
        when Line::Bot::Event::Message
          case event.type
          when Line::Bot::Event::MessageType::Text
            message = reply_text_message(event)
          end
        end
        client.reply_message(event['replyToken'], message) if message
      end

      # 200status は必ず返さなければならない
      head :ok
    end

    private

      # LINEアカウント連携 5. アカウントを連携する
      def complete_linking_account(linkevent)
        nonce = linkevent.nonce.to_s
        linking_user = User.find_by(line_nonce: nonce)

        return set_reply_text("対象のユーザーが見つかりませんでした") unless linking_user

        line_id = linkevent["source"]["userId"]

        # 既に同じLINE IDが登録されているかチェック
        if User.where(line_user_id: line_id).present?
          linking_user.update!(line_nonce: nil)
          return set_reply_text("すでに同じLINE-IDが登録されています")
        end

        linking_user.update!(line_user_id: line_id, line_nonce: nil)
        push_linking_complete_message(linking_user)
        set_reply_text("アカウントの連携が完了しました")
      end

      # LINEアカウント連携解除
      def disconnecting_accounts(user)
        user.update!(line_user_id: nil)
        set_reply_text("LINEアカウントの連携を解除しました")
      end

      def donot_eat_meals(user)
        if destroy_suggestions_all(user)
          set_reply_text("了解しました")
        else
          set_reply_text("提案の削除処理に失敗しました")
        end
      end

      def eat_meals(user)
        if make_record_from_suggestion(user)
          set_reply_text("great!!")
        else
          set_reply_text("既に登録済みか、または何らかの原因により登録処理に失敗しました")
        end
      end

      # アカウント連携完了後、プッシュメッセージを送信
      def push_linking_complete_message(user)
        to_name = user.name
        to_id = user.line_user_id

        message = {
          type: "text",
          text: "ようこそ、#{to_name}さん"
        }

        client.push_message(to_id, message)
      end

      # Event::Messageのテキストの内容により処理を振り分ける
      def reply_text_message(event)
        user = User.find_by(line_user_id: event["source"]["userId"])
        return reply_user_not_found if user.blank?

        case event.message["text"]
        when "アカウント連携解除"
          disconnecting_accounts(user)
        when "BMR確認"
          BmrAndPfcReplier.call(user)
        when "今日の食材"
          SuggestionsReplier.call(user)
        when "食べない"
          donot_eat_meals(user)
        when "食べる"
          eat_meals(user)
        when "健康貯金"
          HealthSavingsReplier.call(user)
        else
          # 所定の文言以外にはエラーメッセージを返す
          set_reply_text("ちょっと何言ってるかわからない")
        end
      end

      # アカウント連携用URIの生成
      def reply_url_for_linking(line_id)
        # 連携手順1. 連携トークンを発行する
        response = client.create_link_token(line_id).body
        parsed_response = JSON.parse(response)

        # 連携手順2. ユーザーを連携URLにリダイレクトする
        uri = URI("https://www.eat-4now.com/line/link")
        uri.query = URI.encode_www_form({ linkToken: parsed_response["linkToken"] })

        return {
          type: "template",
          altText: "アカウント連携はこちらから",
          template: {
            type: "buttons",
            text: "以下のURLからログインし、アカウント連携を行ってください \n" + "なお、連携の解除はいつでも行うことができます。",
            actions: [{
              type: "uri",
              label: "アカウント連携ページ",
              uri: uri
            }]
          }
        }
      end

      def reply_user_not_found
        { type: 'text', text: "ユーザーの取得に失敗しました" }
      end

      # 汎用：テキストメッセージの作成
      def set_reply_text(text)
        { type: 'text', text: text }
      end
  end
end