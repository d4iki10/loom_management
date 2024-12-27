require 'rails_helper'

RSpec.describe ColorNumber, type: :model do
  describe 'ファクトリ' do
    it '有効なファクトリを持つこと' do
      expect(build(:color_number_c001)).to be_valid
      expect(build(:color_number_c002)).to be_valid
      expect(build(:color_number_c003)).to be_valid
      expect(build(:color_number_c004)).to be_valid
      expect(build(:color_number_c005)).to be_valid
      expect(build(:color_number_c006)).to be_valid
      expect(build(:color_number_c007)).to be_valid
      expect(build(:color_number_c008)).to be_valid
    end
  end

  describe 'バリデーション' do
    it '色コードが必須であること' do
      color_number = build(:color_number_c001, color_code: nil)
      expect(color_number).not_to be_valid
      expect(color_number.errors[:color_code]).to include("can't be blank")
    end

    it '色コードが一意であること' do
      create(:color_number_c001, color_code: "C-001")
      duplicate_color = build(:color_number_c002, color_code: "C-001")
      expect(duplicate_color).not_to be_valid
      expect(duplicate_color.errors[:color_code]).to include("has already been taken")
    end
  end

  describe 'アソシエーション' do
    it 'Orderとの関係はhas_manyであること' do
      association = ColorNumber.reflect_on_association(:orders)
      expect(association.macro).to eq :has_many
    end
  end
end
