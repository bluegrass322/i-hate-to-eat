# frozen_string_literal: true

module Line
  class AccountLinkingUriCreater < Line::LinebotBase
    def self.call(client, line_id)
      new(client, line_id).call
    end

    def call
      jsoned_token = link_token
      uri = uri_for_linking(jsoned_token)

      textualize(uri)
    end

    private

      def initialize(client, line_id)
        @client = client
        @line_id = line_id
      end

      # 連携手順1. 連携トークンを発行する
      def link_token
        response = @client.create_link_token(@line_id).body
        JSON.parse(response)
      end

      # 連携手順2. ユーザーを連携URLにリダイレクトする
      def uri_for_linking(jsoned_token)
        uri = URI("https://www.eat-4now.com/line/link")
        uri.query = URI.encode_www_form({ linkToken: jsoned_token["linkToken"] })

        uri
      end

      def textualize(uri)
        {
          type: "template",
          altText: "アカウント連携はこちらから",
          template: {
            type: "buttons",
            text: "以下のURLからログインし、アカウント連携を行ってください \nなお、連携の解除はいつでも行うことができます。",
            actions: [{
              type: "uri",
              label: "アカウント連携ページ",
              uri: uri
            }]
          }
        }
      end
  end
end
