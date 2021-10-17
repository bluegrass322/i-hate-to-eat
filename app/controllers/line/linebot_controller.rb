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
        when Line::Bot::Event::AccountLink
          Rails.logger.debug "アカウント連携イベントを受け取った"
          message = if event.result == "ok"
                      complete_linking_account(event)
                    else
                      "resultがfailedだった"
                    end
        when Line::Bot::Event::Follow
          message = reply_confirm_linking_account
        when Line::Bot::Event::Message
          case event.type
          when Line::Bot::Event::MessageType::Text
            message = reply_text_message(event)
          end
        # when Line::Bot::Event::Unfollow
          # rplyTokenは発行されない
          # 連携解除処理
        end
        client.reply_message(event['replyToken'], message)
      end

      # 200status は必ず返さなければならない
      head :ok
    end

    private

      # TODO: この1手間を挟むのをやめる、いきなりURL発行
      # NOの場合メッセージを削除するよう依頼文？
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
        case event.message["text"]
        when "do linking"
          set_url_for_linking(event["source"]["userId"])
        when "don't linking"
          set_reply_text("引き続きLINE通知以外の機能をご利用ください")
        when "hi"
          set_reply_text("Good morning!")
        when "bye"
          set_reply_text("Good bye!")
        else
          # 所定の文言以外にはエラーメッセージを返す
          set_reply_text("ちょっと何言ってるかわからない")
        end
      end

      def set_reply_text(text)
        { type: 'text', text: text }
      end

      def set_url_for_linking(line_id)
        # 連携手順1. 連携トークンを発行する
        client = Line::Bot::Client.new{ |config|
          config.channel_secret = Rails.application.credentials.line[:CHANNEL_SECRET]
          config.channel_token = Rails.application.credentials.line[:CHANNEL_TOKEN]
        }
        response = client.create_link_token(line_id).body
        parsed_response = JSON.parse(response)

        # 連携手順2. ユーザーを連携URLにリダイレクトする
        # TODO: .queryメソッドを用いてulrにパラメーターを含めるよう修正
        return {
          type: "template",
          altText: "アカウント連携用ページ",
          template: {
            type: "buttons",
            text: "以下のURLから再度ログインし、アカウント連携を行ってください",
            actions: [{
                type: "uri",
                label: "アカウント連携ページ",
                uri: "https://i-hate-to-eat.herokuapp.com/line/link?linkToken=#{parsed_response["linkToken"]}"
            }]
          }
        }
      end

      def complete_linking_account(event)
        nonce = event.nonce
        Rails.logger.debug "Event nonce: #{ nonce }"
        Rails.logger.debug "Event nonce class: #{ nonce.class }"

        # nonceで該当するユーザーを取得する
        linking_user = User.find_by(line_nonce: nonce.to_s)
        Rails.logger.debug "Users nonce: #{ linking_user.line_nonce }"
        Rails.logger.debug "Boolean: #{ linking_user.line_nonce == nonce.to_s }"

        # アカウント連携イベントに含まれるnonceとセッションに保存したnonceが一致するか？
        # session[:nonce].keys[0] == event.nonce

        # 同じLINEuserIDを持ったユーザーが既に存在しないか？
        # unless User.where(line_user_id: )

        # LINEのuserIDを該当のuserレコードに保存
        # user = User.find(session[:nonce].keys[0])
        # user.line_user_id = event["source"]["userId"]
        # user.save

        # 必ずnonceを削除！！！
        linking_user.update!(line_nonce: "finished")
        Rails.logger.debug "Users nonce delete..."
        Rails.logger.debug "Users nonce: #{ linking_user.line_nonce }"

        # 確認としてuser.nameをメッセージで返しておくか？
        return "#{ linking_user.name }のアカウント連携イベントが完了した"
      end
  end
end
