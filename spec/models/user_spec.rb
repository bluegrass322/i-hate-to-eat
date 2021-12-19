# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it "factoryがvalidなインスタンスを生成すること" do
    expect(build(:user)).to be_valid
  end

  describe "バリデーション" do
    context "ユーザー名、メールアドレス、パスワード、パスワード（確認）がある場合" do        
      it "validになること" do
        user = build(:user,
          name: "test",
          email: "test@example.com",
          password: "password",
          password_confirmation: "password"
        )
        user.valid?

        expect(user).to be_valid
        expect(user.errors).to be_empty
      end
    end

    describe "ユーザー名" do
      context "正常系" do        
        context "大文字と小文字で区別されている場合" do
          it "validになること" do
            other_user = create(:user, name: "Test")
    
            user = build(:user, name: "test")
            user.valid?
    
            expect(user).to be_valid
            expect(user.errors).to be_empty
          end
        end
      end

      context "異常系" do        
        context "nilの場合" do
          it "invalidになること" do
            user = build(:user, name: nil)
            user.valid?
  
            expect(user).to be_invalid
            expect(user.errors[:name]).to include "を入力してください"
          end
        end
  
        context "空文字の場合" do
          it "invalidになること" do
            user = build(:user, name: "")
            user.valid?
  
            expect(user).to be_invalid
            expect(user.errors[:name]).to include "を入力してください"
          end
        end
  
        context "重複した値の場合" do
          it "invalidになること" do
            other_user = create(:user, name: "Test")
  
            user = build(:user, name: "Test")
            user.valid?
  
            expect(user).to be_invalid
            expect(user.errors[:name]).to include "はすでに存在します"
          end
        end
      end
    end

    describe "メールアドレス" do
      context "異常系" do
        context "nilの場合" do
          it "invalidになること" do
            user = build(:user, email: nil)
            user.valid?
  
            expect(user).to be_invalid
            expect(user.errors[:email]).to include "を入力してください"
          end
        end
  
        context "空文字の場合" do
          it "invalidになること" do
            user = build(:user, email: "")
            user.valid?
  
            expect(user).to be_invalid
            expect(user.errors[:email]).to include "を入力してください"
          end
        end
  
        context "重複した値の場合" do
          it "invalidになること" do
            other_user = create(:user)
  
            user = build(:user, email: other_user.email)
            user.valid?
  
            expect(user).to be_invalid
            expect(user.errors[:email]).to include "はすでに存在します"
          end
        end
  
        context "アドレスの形式でない場合" do
          it "invalidになること" do
            user = build(:user, email: "test")
            user.valid?
  
            expect(user).to be_invalid
            expect(user.errors[:email]).to include "メールアドレスの形式が正しくありません"
          end
        end
      end
    end

    describe "パスワード" do
      context "正常系" do        
        context "7文字以上の場合" do
          it "validになること" do
            pass = "a" * 7
  
            user = build(:user, password: pass, password_confirmation: pass)
            user.valid?
  
            expect(user).to be_valid
            expect(user.errors).to be_empty
          end
        end
      end

      context "異常系" do
        context "nilの場合" do
          it "invalidになること" do
            user = build(:user, name: nil)
            user.valid?

            expect(user).to be_invalid
            expect(user.errors[:name]).to include "を入力してください"
          end
        end

        context "空文字の場合" do
          it "invalidになること" do
            user = build(:user, name: "")
            user.valid?

            expect(user).to be_invalid
            expect(user.errors[:name]).to include "を入力してください"
          end
        end

        context "6文字の場合" do
          it "invalidになること" do
            pass = "a" * 6

            user = build(:user, password: pass)
            user.valid?

            expect(user).to be_invalid
            expect(user.errors[:password]).to include "は7文字以上で入力してください"
          end
        end

        context "passwordとpassword_confirmationの値が異なる場合" do
          it "invalidになること" do
            user = build(:user, password: "password", password_confirmation: "otherpass")
            user.valid?

            expect(user).to be_invalid
            expect(user.errors[:password_confirmation]).to include "とパスワードの入力が一致しません"
          end
        end
      end
    end

    describe "生年月日" do
      context "正常系" do
        context "現在18歳になる生年月日の場合" do
          it "validになること" do
            date = Time.current.ago(18.years)

            user = build(:user, birth: date)
            user.valid?

            expect(user).to be_valid
            expect(user.errors).to be_empty
          end
        end

        context "現在59歳になる生年月日の場合" do
          it "validになること" do
            date = Time.current.ago(59.years)

            user = build(:user, birth: date)
            user.valid?

            expect(user).to be_valid
            expect(user.errors).to be_empty
          end
        end
      end

      context "異常系" do
        context "未来の日付の場合" do
          it "invalidになること" do
            date = Time.current.since(1.day)
            
            user = build(:user, birth: date)
            user.valid?

            expect(user).to be_invalid
            expect(user.errors[:birth]).to include "未来の日付は入力できません"
          end
        end

        context "現在17歳になる生年月日の場合" do
          it "invalidになること" do
            date = Time.current.ago(17.years)

            user = build(:user, birth: date)
            user.valid?

            expect(user).to be_invalid
            expect(user.errors[:birth]).to include "本サービスは18歳以上60歳未満の方が対象です"
          end
        end

        context "現在60歳になる生年月日の場合" do
          it "invalidになること" do
            date = Time.current.ago(60.years)

            user = build(:user, birth: date)
            user.valid?

            expect(user).to be_invalid
            expect(user.errors[:birth]).to include "本サービスは18歳以上60歳未満の方が対象です"
          end  
        end
      end
    end

    describe "身長" do
      context "正常系" do
        context "整数値の場合" do
          it "validになること" do
            user = build(:user, height: 160)
            user.valid?

            expect(user).to be_valid
            expect(user.errors).to be_empty
          end
        end
      end

      context "異常系" do
        context "数値でない場合" do
          it "invalidになること" do
            user = build(:user, height: "string")
            user.valid?

            expect(user).to be_invalid
            expect(user.errors[:height]).to include "は数値で入力してください"
          end
        end

        context "少数の場合" do
          it "invalidになること" do
            user = build(:user, height: 160.0)
            user.valid?

            expect(user).to be_invalid
            expect(user.errors[:height]).to include "は整数で入力してください"
          end
        end
      end
    end

    describe "体重" do
      context "正常系" do
        context "数値の場合" do
          it "validになること" do
            user = build(:user, weight: 50.0)
            user.valid?

            expect(user).to be_valid
            expect(user.errors).to be_empty
          end
        end
      end

      context "異常系" do
        context "数値でない場合" do
          it "invalidになること" do
            user = build(:user, weight: "string")
            user.valid?

            expect(user).to be_invalid
            expect(user.errors[:weight]).to include "は数値で入力してください"
          end
        end
      end
    end

    describe "bmr" do
      context "正常系" do
        context "数値の場合" do
          it "validになること" do
            user = build(:user, bmr: 1600.0)
            user.valid?

            expect(user).to be_valid
            expect(user.errors).to be_empty
          end
        end
      end

      context "異常系" do
        context "数値でない場合" do
          it "invalidになること" do
            user = build(:user, bmr: "string")
            user.valid?

            expect(user).to be_invalid
            expect(user.errors[:bmr]).to include "は数値で入力してください"
          end
        end
      end
    end

    describe "health_savings" do
      context "正常系" do
        context "整数の場合" do
          it "validになること" do
            user = build(:user, health_savings: 10)
            user.valid?

            expect(user).to be_valid
            expect(user.errors).to be_empty
          end
        end
      end

      context "異常系" do
        context "数値でない場合" do
          it "invalidになること" do
            user = build(:user, health_savings: "string")
            user.valid?

            expect(user).to be_invalid
            expect(user.errors[:health_savings]).to include "は数値で入力してください"
          end
        end

        context "少数の場合" do
          it "invalidになること" do
            user = build(:user, health_savings: 10.0)
            user.valid?

            expect(user).to be_invalid
            expect(user.errors[:health_savings]).to include "は整数で入力してください"
          end
        end
      end
    end

    describe "line_uesr_id" do
      context "異常系" do
        context "重複した値の場合" do
          it "invalidになること" do
            other_user = create(:user, line_user_id: "test")

            user = build(:user, line_user_id: other_user.line_user_id)
            user.valid?

            expect(user).to be_invalid
            expect(user.errors[:line_user_id]).to include "はすでに存在します"
          end
        end
      end
    end

    describe "mealtime_first" do
      context "正常系" do
        context "午前7時の場合" do
          it "validになること" do
            time = Time.local(2021, 1, 1, 7, 0)

            user = build(:user, mealtime_first: time)
            user.valid?

            expect(user).to be_valid
            expect(user.errors).to be_empty
          end
        end

        context "午後11時の場合" do
          it "validになること" do
            time = Time.local(2021, 1, 1, 23, 0)

            user = build(:user, mealtime_first: time)
            user.valid?

            expect(user).to be_valid
            expect(user.errors).to be_empty
          end
        end
      end

      context "異常系" do
        context "午前6時59分の場合" do
          it "invalidになること" do
            time = Time.local(2021, 1, 1, 6, 59)

            user = build(:user, mealtime_first: time)
            user.valid?

            expect(user).to be_invalid
            expect(user.errors[:mealtime_first]).to include "通知の時間は7:00 - 23:00の間で設定してください"
          end
        end

        context "11時1分の場合" do
          it "invalidになること" do
            time = Time.local(2021, 1, 1, 23, 1)

            user = build(:user, mealtime_first: time)
            user.valid?

            expect(user).to be_invalid
            expect(user.errors[:mealtime_first]).to include "通知の時間は7:00 - 23:00の間で設定してください"
          end
        end
      end
    end
  end

  describe "インスタンスメソッド" do
    describe ":calc_age" do
      context "現在18歳になる生年月日の場合" do
        it "戻り値が18になること" do
          date = Time.current.ago(18.years)
          user = build(:user, birth: date)

          expect(user.calc_age).to eq 18
        end
      end

      context "現在59歳になる生年月日の場合" do
        fit "戻り値が59になること" do
          date = Time.current.ago(59.years)
          user = build(:user, birth: date)

          expect(user.calc_age).to eq 59
        end
      end
    end
  end
end

# == Schema Information
#
# Table name: users
#
#  id                           :bigint           not null, primary key
#  birth                        :date
#  bmr                          :float            default(0.0), not null
#  crypted_password             :string
#  email_bidx                   :string           not null
#  email_ciphertext             :text             not null
#  gender                       :integer          default("female"), not null
#  health_savings               :integer          default(0), not null
#  height                       :integer          default(0), not null
#  line_nonce                   :string
#  line_notification_enabled    :boolean          default(FALSE), not null
#  line_user_id_bidx            :string
#  line_user_id_ciphertext      :text
#  mealtime_first               :time
#  name                         :string           not null
#  percentage_carbohydrate      :float            default(0.6), not null
#  percentage_fat               :float            default(0.2), not null
#  percentage_protein           :float            default(0.2), not null
#  remember_me_token            :string
#  remember_me_token_expires_at :datetime
#  role                         :integer          default("general"), not null
#  salt                         :string
#  weight                       :float            default(0.0), not null
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  dietary_reference_intake_id  :bigint           default(0), not null
#
# Indexes
#
#  index_users_on_dietary_reference_intake_id  (dietary_reference_intake_id)
#  index_users_on_email_bidx                   (email_bidx) UNIQUE
#  index_users_on_line_user_id_bidx            (line_user_id_bidx) UNIQUE
#  index_users_on_name                         (name) UNIQUE
#  index_users_on_remember_me_token            (remember_me_token)
#
# Foreign Keys
#
#  fk_rails_...  (dietary_reference_intake_id => dietary_reference_intakes.id)
#
