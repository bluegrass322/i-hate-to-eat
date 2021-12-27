require 'rails_helper'

RSpec.describe "api/v1/user_withdrawal", type: :request do
  describe "#destroy" do
    before do
      signup_and_login
    end

    context "正常系" do
      context "引数がcurrent_userのidである場合" do        
        it "退会に成功すること" do
          expect {
            delete api_v1_user_withdrawal_path, params: { id: @user.id }
          }.to change(User, :count).by(-1)
  
          expect(response).to have_http_status("200")

        end
      end
    end

    context "異常系" do
      context "引数がcurrent_userのidでない場合" do        
        it "退会に失敗すること" do
          expect {
            delete api_v1_user_withdrawal_path, params: { id: 5 }
          }.to change(User, :count).by(0)
  
          expect(response).to have_http_status("404")
        end
      end
    end
  end
end