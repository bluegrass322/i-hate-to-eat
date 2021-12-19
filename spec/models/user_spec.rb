# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it "factoryがvalidなインスタンスを生成すること" do
    expect(build(:user)).to be_valid
  end

  describe "バリデーション" do
    # 新規登録時に最低限必要な属性について
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
  
        context "重複している場合" do
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
  
        context "重複している場合" do
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
