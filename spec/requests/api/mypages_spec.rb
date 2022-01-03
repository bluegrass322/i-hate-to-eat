require 'rails_helper'

RSpec.describe "/api/v1/mypage", type: :request do
  describe "#show" do
    context "正常系" do
      context "ログイン済みの場合" do
        it "情報の取得に成功すること" do
          signup_and_login(:full_params)
          get api_v1_mypage_path

          expect(response).to have_http_status(:ok)

          res = JSON.parse(response.body)
          expect(res).to match(hash_including("bmr_params", "pfc_params", "dri_params"))
          expect(res["bmr_params"]).to match(hash_including("gender", "birth", "height", "weight", "bmr"))
          expect(res["pfc_params"]).to match(hash_including("pct", "amt"))
          expect(res["pfc_params"]["pct"]).to match(hash_including("protein", "fat", "carbohydrate"))
          expect(res["pfc_params"]["amt"]).to match(hash_including("protein", "fat", "carbohydrate"))
        end
      end
    end

    context "異常系" do
      context "ログインしていない場合" do
        it "情報の取得に失敗すること" do
          get api_v1_mypage_path

          expect(response).to have_http_status(:bad_request)
          expect(response.body).to include "ログインしてください"
        end
      end
    end
  end
end