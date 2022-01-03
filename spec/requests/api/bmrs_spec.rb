require 'rails_helper'

RSpec.describe "/api/v1/bmr", type: :request do
  describe "#update" do
    before do
      # DietaryReferenceIntakeのseedデータ
      load Rails.root.join("db/seeds/dietary_reference_intake.rb")

      signup_and_login(:full_params)
    end

    describe "性別・生年月日・身長・体重" do
      context "正常系" do
        context "validな値が与えられた場合" do
          it "BMR関連情報の更新に成功すること" do
            valid_params = {
              gender: "male",
              birth: Time.current.ago(20.years),
              height: 140,
              weight: 40
            }
            patch api_v1_bmr_path, params: { user: valid_params }

            expect(response).to have_http_status(:ok)
            
            user = User.first
            expect(user.bmr).not_to eq @user.bmr
            expect(user.gender).to eq "male"
            expect(user.birth.strftime("%F")).to eq Time.current.ago(20.years).strftime("%F")
            expect(user.height).to eq 140
            expect(user.weight).to eq 40
          end
        end
      end

      context "異常系" do
        context "invalidな値が与えられた場合" do
          it "BMR関連情報の更新に失敗すること" do
            invalid_params = {
              gender: nil,
              birth: Time.current.ago(10.years),
              height: nil,
              weight: nil
            }
            patch api_v1_bmr_path, params: { user: invalid_params }

            expect(response).to have_http_status(:bad_request)
            expect(User.first.bmr).to eq @user.bmr
          end
        end
      end
    end

    describe "dietary_reference_intake_id" do
      context "正常系" do
        context "性別が女性の場合" do
          context "年齢が18歳の場合" do
            it "適切なDietayReferenceIntakeが設定されること" do
              valid_params = {
                gender: "female",
                birth: Time.current.ago(18.years),
              }
              patch api_v1_bmr_path, params: { user: valid_params }

              expect(response).to have_http_status(:ok)

              dri = User.first.dietary_reference_intake
              expect(dri.gender).to eq "female"
              expect(dri.age_bottom).to eq 18
            end
          end

          context "年齢が29歳の場合" do
            it "適切なDietayReferenceIntakeが設定されること" do
              valid_params = {
                gender: "female",
                birth: Time.current.ago(29.years),
              }
              patch api_v1_bmr_path, params: { user: valid_params }

              expect(response).to have_http_status(:ok)

              dri = User.first.dietary_reference_intake
              expect(dri.gender).to eq "female"
              expect(dri.age_bottom).to eq 18
            end
          end

          context "年齢が30歳の場合" do 
            it "適切なDietayReferenceIntakeが設定されること" do
              valid_params = {
                gender: "female",
                birth: Time.current.ago(30.years),
              }
              patch api_v1_bmr_path, params: { user: valid_params }

              expect(response).to have_http_status(:ok)

              dri = User.first.dietary_reference_intake
              expect(dri.gender).to eq "female"
              expect(dri.age_bottom).to eq 30
            end
          end

          context "年齢が49歳の場合" do
            it "適切なDietayReferenceIntakeが設定されること" do
              valid_params = {
                gender: "female",
                birth: Time.current.ago(49.years),
              }
              patch api_v1_bmr_path, params: { user: valid_params }

              expect(response).to have_http_status(:ok)

              dri = User.first.dietary_reference_intake
              expect(dri.gender).to eq "female"
              expect(dri.age_bottom).to eq 30
            end
          end

          context "年齢が50歳の場合" do
            it "適切なDietayReferenceIntakeが設定されること" do
              valid_params = {
                gender: "female",
                birth: Time.current.ago(50.years),
              }
              patch api_v1_bmr_path, params: { user: valid_params }

              expect(response).to have_http_status(:ok)

              dri = User.first.dietary_reference_intake
              expect(dri.gender).to eq "female"
              expect(dri.age_bottom).to eq 50
            end
          end

          context "年齢が60歳の場合" do
            it "適切なDietayReferenceIntakeが設定されること" do
              valid_params = {
                gender: "female",
                birth: Time.current.ago(59.years),
              }
              patch api_v1_bmr_path, params: { user: valid_params }

              expect(response).to have_http_status(:ok)

              dri = User.first.dietary_reference_intake
              expect(dri.gender).to eq "female"
              expect(dri.age_bottom).to eq 50
            end
          end
        end

        context "性別が男性の場合" do
          context "年齢が18歳の場合" do
            it "適切なDietayReferenceIntakeが設定されること" do
              valid_params = {
                gender: "male",
                birth: Time.current.ago(18.years),
              }
              patch api_v1_bmr_path, params: { user: valid_params }

              expect(response).to have_http_status(:ok)

              dri = User.first.dietary_reference_intake
              expect(dri.gender).to eq "male"
              expect(dri.age_bottom).to eq 18
            end
          end

          context "年齢が29歳の場合" do
            it "適切なDietayReferenceIntakeが設定されること" do
              valid_params = {
                gender: "male",
                birth: Time.current.ago(29.years),
              }
              patch api_v1_bmr_path, params: { user: valid_params }

              expect(response).to have_http_status(:ok)

              dri = User.first.dietary_reference_intake
              expect(dri.gender).to eq "male"
              expect(dri.age_bottom).to eq 18
            end
          end

          context "年齢が30歳の場合" do 
            it "適切なDietayReferenceIntakeが設定されること" do
              valid_params = {
                gender: "male",
                birth: Time.current.ago(30.years),
              }
              patch api_v1_bmr_path, params: { user: valid_params }

              expect(response).to have_http_status(:ok)

              dri = User.first.dietary_reference_intake
              expect(dri.gender).to eq "male"
              expect(dri.age_bottom).to eq 30
            end
          end

          context "年齢が49歳の場合" do
            it "適切なDietayReferenceIntakeが設定されること" do
              valid_params = {
                gender: "male",
                birth: Time.current.ago(49.years),
              }
              patch api_v1_bmr_path, params: { user: valid_params }

              expect(response).to have_http_status(:ok)

              dri = User.first.dietary_reference_intake
              expect(dri.gender).to eq "male"
              expect(dri.age_bottom).to eq 30
            end
          end

          context "年齢が50歳の場合" do
            it "適切なDietayReferenceIntakeが設定されること" do
              valid_params = {
                gender: "male",
                birth: Time.current.ago(50.years),
              }
              patch api_v1_bmr_path, params: { user: valid_params }

              expect(response).to have_http_status(:ok)

              dri = User.first.dietary_reference_intake
              expect(dri.gender).to eq "male"
              expect(dri.age_bottom).to eq 50
            end
          end

          context "年齢が60歳の場合" do
            it "適切なDietayReferenceIntakeが設定されること" do
              valid_params = {
                gender: "male",
                birth: Time.current.ago(59.years),
              }
              patch api_v1_bmr_path, params: { user: valid_params }

              expect(response).to have_http_status(:ok)

              dri = User.first.dietary_reference_intake
              expect(dri.gender).to eq "male"
              expect(dri.age_bottom).to eq 50
            end
          end
        end
      end
    end
  end
end