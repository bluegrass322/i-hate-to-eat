require 'rails_helper'

RSpec.describe "api/v1/registrations", type: :request do
  it "dietary_reference_intakesのfactoryがvalidなインスタンスを生成すること" do
    expect(create(:dietary_reference_intake)).to be_valid
  end

  describe "#create" do
    let(:user_params) { attributes_for(:user) }

    before do
      create(:dietary_reference_intake)
    end

    context "正常系" do
      context "ユーザー名、メールアドレス、パスワード、パスワード（確認）がある場合" do
        it "新規登録に成功すること" do
          expect {
            post api_v1_registration_path, params: { user: user_params }
          }.to change(User, :count).by(1)

          user = User.first
          expect(response).to have_http_status("200")
          expect(response.body).to include user.id.to_s
          expect(user.dietary_reference_intake_id).to eq DietaryReferenceIntake.first.id
        end
      end
    end

    context "異常系" do
      context "ユーザー名がない場合" do
        it "新規登録に失敗すること" do
          user_params[:name] = nil

          expect {
            post api_v1_registration_path, params: { user: user_params }
          }.to change(User, :count).by(0)

          expect(response).to have_http_status("400")
          expect(response.body).to include "を入力してください"
        end
      end

      context "メールアドレスがない場合" do
        it "新規登録に失敗すること" do
          user_params[:email] = nil

          expect {
            post api_v1_registration_path, params: { user: user_params }
          }.to change(User, :count).by(0)

          expect(response).to have_http_status("400")
          expect(response.body).to include "を入力してください"
        end
      end

      context "パスワードがない場合" do
        it "新規登録に失敗すること" do
          user_params[:password] = nil

          expect {
            post api_v1_registration_path, params: { user: user_params }
          }.to change(User, :count).by(0)

          expect(response).to have_http_status("400")
          expect(response.body).to include "文字以上で入力してください"
        end
      end

      context "パスワード（確認）がない場合" do
        it "新規登録に失敗すること" do
          user_params[:password_confirmation] = nil

          expect {
            post api_v1_registration_path, params: { user: user_params }
          }.to change(User, :count).by(0)

          expect(response).to have_http_status("400")
          expect(response.body).to include "を入力してください"
        end
      end

      context "パスワードとパスワード（確認）の値が異なる場合" do
        it "新規登録に失敗すること" do
          user_params[:password] = "password"
          user_params[:password_confirmation] = "otherpass"

          expect {
            post api_v1_registration_path, params: { user: user_params }
          }.to change(User, :count).by(0)

          expect(response).to have_http_status("400")
          expect(response.body).to include "入力が一致しません"
        end
      end
    end
  end
end