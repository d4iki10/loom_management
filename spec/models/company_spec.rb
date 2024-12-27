require 'rails_helper'

RSpec.describe Company, type: :model do
  describe 'ファクトリ' do
    it '有効なファクトリを持つこと' do
      expect(build(:tonya_company)).to be_valid
      expect(build(:hataya_a_company)).to be_valid
      expect(build(:hataya_b_company)).to be_valid
      expect(build(:hataya_c_company)).to be_valid
      expect(build(:hataya_d_company)).to be_valid
      expect(build(:hataya_e_company)).to be_valid
      expect(build(:hataya_f_company)).to be_valid
      expect(build(:hataya_g_company)).to be_valid
    end
  end

  describe 'バリデーション' do
    it '名前が必須であること' do
      company = build(:company, name: nil)
      expect(company).not_to be_valid
      expect(company.errors[:name]).to include("can't be blank")
    end

    it '名前が一意であること' do
      create(:tonya_company, name: "問屋")
      duplicate_company = build(:tonya_company, name: "問屋")
      expect(duplicate_company).not_to be_valid
      expect(duplicate_company.errors[:name]).to include("has already been taken")
    end
  end

  describe 'アソシエーション' do
    it 'Userとの関係はhas_manyであること' do
      association = Company.reflect_on_association(:users)
      expect(association.macro).to eq :has_many
    end
    it 'Orderとの関係はhas_manyであること' do
      association = Company.reflect_on_association(:orders)
      expect(association.macro).to eq :has_many
    end
    it 'Machineとの関係はhas_manyであること' do
      association = Company.reflect_on_association(:machines)
      expect(association.macro).to eq :has_many
    end
  end
end
