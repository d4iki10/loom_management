# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ファクトリ' do
    # ユーザーファクトリと対応するカンパニーファクトリのペアを定義
    FACTORY_PAIRS = {
      user_yamada_taro: :tonya_company,
      user_sato_hanako: :hataya_a_company,
      user_suzuki_ichiro: :hataya_b_company,
      user_otani_shohei: :hataya_c_company,
      user_tanaka_ken: :hataya_d_company,
      user_nakamura_misaki: :hataya_e_company,
      user_kobayashi_makoto: :hataya_f_company,
      user_takahashi_naoko: :hataya_g_company,
      user_ito_sho: :hataya_h_company
    }.freeze

    shared_examples '有効なファクトリ' do |user_factory, company_factory|
      it "有効なファクトリを持つこと #{user_factory}" do
        company = create(company_factory)
        user = build(user_factory, company: company)
        expect(user).to be_valid
      end
    end

    FACTORY_PAIRS.each do |user_factory, company_factory|
      include_examples '有効なファクトリ', user_factory, company_factory
    end
  end

  describe 'バリデーション' do
    it '名前が必須であること' do
      user = build(:user_yamada_taro, name: nil)
      expect(user).not_to be_valid
      expect(user.errors[:name]).to include("can't be blank")
    end

    it 'メールアドレスが一意であること' do
      create(:user_yamada_taro, email: "aaa@example.com")
      duplicate_user = build(:user_sato_hanako, email: "aaa@example.com")
      expect(duplicate_user).not_to be_valid
      expect(duplicate_user.errors[:email]).to include("has already been taken")
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
