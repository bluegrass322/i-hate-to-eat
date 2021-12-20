require 'rails_helper'

RSpec.describe "api/v1/authentications", type: :request do
  describe "#create" do
    before do
      create(:dietary_reference_intake)

      @user = create(:user)
      @login_params = {name: @user.name, password: "password"}
    end

    context "正常系" do
      context "正しいユーザー名、パスワードがある場合" do
        it "ログインに成功すること" do
          post api_v1_authentication_path, params: @login_params

          expect(response).to have_http_status("200")
          expect(response.body).to include @user.id.to_s
        end
      end
    end

    context "異常系" do
      context "ユーザー名がない場合" do
        it "ログインに失敗すること" do
          @login_params[:name] = nil

          post api_v1_authentication_path, params: @login_params

          expect(response).to have_http_status("400")
          expect(response.body).to include "ログインに失敗しました"
        end
      end

      context "ユーザー名が間違っている場合" do
        it "ログインに失敗すること" do
          @login_params[:name] = "error"

          post api_v1_authentication_path, params: @login_params

          expect(response).to have_http_status("400")
          expect(response.body).to include "ログインに失敗しました"
        end
      end

      context "パスワードがない場合" do
        it "ログインに失敗すること" do
          @login_params[:password] = nil

          post api_v1_authentication_path, params: @login_params

          expect(response).to have_http_status("400")
          expect(response.body).to include "ログインに失敗しました"
        end
      end

      context "パスワードが間違っている場合" do
        it "ログインに失敗すること" do
          @login_params[:password] = "error"

          post api_v1_authentication_path, params: @login_params

          expect(response).to have_http_status("400")
          expect(response.body).to include "ログインに失敗しました"
        end
      end
    end
  end

  describe "#destroy" do
    before do
      signup_and_login
    end

    it "ログアウトに成功すること" do
      delete api_v1_authentication_path

      expect(response).to have_http_status("200")
    end
  end
end