require 'rails_helper'

RSpec.describe "api/v1/user_accounts", type: :request do
  describe "#show" do
    before do
      signup_and_login(:full_params)
    end

    context "正常系" do
      it "ユーザー名・メールアドレス・LINE通知のON/OFF・通知時間の4要素が含まれていること" do
        get api_v1_user_account_path

        expect(response).to have_http_status(:ok)
        expect(response.body).to include @user.name,
                                         @user.email,
                                         @user.line_notification_enabled.to_s,
                                         @user.mealtime_first.strftime('%R')
      end
    end
  end

  describe "#update" do
    before do
      signup_and_login(:full_params)
    end

    context "正常系" do
      context "validな値が与えられた場合" do
        it "更新処理に成功すること" do
          valid_params = {
            name: "changed_name",
            email: "changed_eamil@example.com",
            line_notification_enabled: false,
            mealtime_first: Time.local(2021, 1, 1, 20, 30)
          }
          patch api_v1_user_account_path, params: { user: valid_params }

          expect(response).to have_http_status(:ok)

          user = User.first
          expect(user.name).to eq "changed_name"
          expect(user.email).to eq "changed_eamil@example.com"
          expect(user.line_notification_enabled).to be false
          expect(user.mealtime_first.strftime('%R')).to eq "20:30"
        end
      end
    end

    context "異常系" do
      context "invalidな値が与えられた場合" do
        it "更新処理に失敗すること" do
          invalid_params = {
            name: nil,
            email: nil,
            line_notification_enabled: nil,
            mealtime_first: nil
          }
          patch api_v1_user_account_path, params: { user: invalid_params }

          expect(response).to have_http_status(:bad_request)
          expect(response.body).to include "入力してください"

          user = User.first
          expect(user.name).to eq @user.name
          expect(user.email).to eq @user.email
          expect(user.line_notification_enabled).to eq @user.line_notification_enabled
          expect(user.mealtime_first.strftime('%R')).to eq @user.mealtime_first.strftime('%R')
        end
      end
    end
  end
end