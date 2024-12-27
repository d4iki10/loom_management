require 'rails_helper'

RSpec.describe ProductNumber, type: :model do
  describe 'ファクトリ' do
    it '有効なファクトリを持つこと' do
      expect(build(:product_number_pn100)).to be_valid
      expect(build(:product_number_pn200)).to be_valid
      expect(build(:product_number_pn300)).to be_valid
      expect(build(:product_number_pn400)).to be_valid
      expect(build(:product_number_pn500)).to be_valid
    end
  end

  describe 'バリデーション' do
    it '番号が必須であること' do
      product_number = build(:product_number_pn100, number: nil)
      expect(product_number).not_to be_valid
      expect(product_number.errors[:number]).to include("can't be blank")
    end

    it '番号が一意であること' do
      create(:product_number_pn100, number: "PN-100")
      duplicate_pn = build(:product_number_pn200, number: "PN-100")
      expect(duplicate_pn).not_to be_valid
      expect(duplicate_pn.errors[:number]).to include("has already been taken")
    end
  end

  describe 'アソシエーション' do
    it 'Orderとの関係はhas_manyであること' do
      association = ProductNumber.reflect_on_association(:orders)
      expect(association.macro).to eq :has_many
    end
  end
end
