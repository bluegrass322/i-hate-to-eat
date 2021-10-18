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
          message = if event.result == "ok"
                      complete_linking_account(event)
                    else
                      set_reply_text("アカウントの連携に失敗しました")
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

      def disconnecting_accounts(line_id)
        target_user = User.where(line_user_id: line_id).to_a
        Rails.logger.debug "Target: #{target_user}"

        if target_user.present?
          target_uesr.each { |u| u.update!(line_user_id: nil) }
          Rails.logger.debug "Target ID: #{target_user.line_user_id}"
          set_reply_text("LINEアカウントの連携を解除しました")
        else
          set_reply_text("ユーザーの取得に失敗しました")
        end
      end

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
        when "delete linking"
          disconnecting_accounts(event["source"]["userId"])
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

      def complete_linking_account(linkevent)
        # 5. アカウントを連携する
        line_id = linkevent["source"]["userId"]
        return set_reply_text("すでに同じLINE-IDが登録されています") if User.where(line_user_id: line_id).present?

        nonce = linkevent.nonce.to_s
        linking_user = User.find_by(line_nonce: nonce)

        if linking_user
          # nonceは必ず削除
          linking_user.update!(line_user_id: line_id, line_nonce: nil)

          push_linking_complete_message(linking_user)
          set_reply_text("アカウントの連携が完了しました")
        else
          set_reply_text("対象のユーザーが見つかりませんでした")
        end
      end

      def push_linking_complete_message(user)
        to_name = user.name
        to_id = user.line_user_id

        message = {
          type: "text",
          text: "ようこそ、#{to_name}さん"
        }
        client = Line::Bot::Client.new do |config|
          config.channel_secret = Rails.application.credentials.line[:CHANNEL_SECRET]
          config.channel_token = Rails.application.credentials.line[:CHANNEL_TOKEN]
        end
        response = client.push_message(to_id, message)
        p response
      end
  end
end
