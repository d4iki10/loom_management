require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ファクトリ' do
    it '有効なファクトリを持つこと' do
      company = create(:tonya_company)
      expect(build(:user_yamada_taro, company: company)).to be_valid
      company_a = create(:hataya_a_company)
      expect(build(:user_sato_hanako, company: company_a)).to be_valid
      company_b = create(:hataya_b_company)
      expect(build(:user_suzuki_ichiro, company: company_b)).to be_valid
      company_c = create(:hataya_c_company)
      expect(build(:user_otani_shohei, company: company_c)).to be_valid
      company_d = create(:hataya_d_company)
      expect(build(:user_tanaka_ken, company: company_d)).to be_valid
      company_e = create(:hataya_e_company)
      expect(build(:user_nakamura_misaki, company: company_e)).to be_valid
      company_f = create(:hataya_f_company)
      expect(build(:user_kobayashi_makoto, company: company_f)).to be_valid
      company_g = create(:hataya_g_company)
      expect(build(:user_takahashi_naoko, company: company_g)).to be_valid
      company_h = create(:hataya_h_company)
      expect(build(:user_ito_sho, company: company_h)).to be_valid
    end
  end

  describe 'バリデーション' do
    it '名前が必須であること' do
      user = build(:user_yamada_taro, name: nil)
      expect(user).not_to be_valid
      expect(user.errors[:name]).to include("can't be blank")
    end

    it 'メールアドレスが必須であること' do
      user = build(:user_yamada_taro, email: nil)
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("can't be blank")
    end

    it 'メールアドレスが一意であること' do
      create(:user_yamada_taro, email: "aaa@example.com")
      duplicate_user = build(:user_sato_hanako, email: "aaa@example.com")
      expect(duplicate_user).not_to be_valid
      expect(duplicate_user.errors[:email]).to include("has already been taken")
    end

    it '電話番号が必須であること' do
      user = build(:user_yamada_taro, phone_number: nil)
      expect(user).not_to be_valid
      expect(user.errors[:phone_number]).to include("can't be blank")
    end

    it '会社が必須であること' do
      user = build(:user_yamada_taro, company: nil)
      expect(user).not_to be_valid
      expect(user.errors[:company]).to include("must exist")
    end

    it 'パスワードが6文字以上であること' do
      user = build(:user_yamada_taro, password: '12345', password_confirmation: '12345')
      expect(user).not_to be_valid
      expect(user.errors[:password]).to include("is too short (minimum is 6 characters)")
    end

    it 'パスワード確認が一致していること' do
      user = build(:user_yamada_taro, password_confirmation: 'wrongpassword')
      expect(user).not_to be_valid
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end
  end

  describe 'アソシエーション' do
    it '会社との関係はbelongs_toであること' do
      association = User.reflect_on_association(:company)
      expect(association.macro).to eq :belongs_to
    end
  end
end
