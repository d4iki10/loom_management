require 'rails_helper'

RSpec.describe MachineType, type: :model do
  describe 'ファクトリ' do
    it '有効なファクトリを持つこと' do
      expect(build(:machine_type_dobby)).to be_valid
      expect(build(:machine_type_jacquard)).to be_valid
    end
  end

  describe 'バリデーション' do
    it '名前が必須であること' do
      machine_type = build(:machine_type_dobby, name: nil)
      expect(machine_type).not_to be_valid
      expect(machine_type.errors[:name]).to include("can't be blank")
    end

    it '名前が一意であること' do
      create(:machine_type_dobby, name: "ドビー")
      duplicate_mt = build(:machine_type_jacquard, name: "ドビー")
      expect(duplicate_mt).not_to be_valid
      expect(duplicate_mt.errors[:name]).to include("has already been taken")
    end
  end

  describe 'アソシエーション' do
    it 'Machineとの関係はhas_manyであること' do
      association = MachineType.reflect_on_association(:machines)
      expect(association.macro).to eq :has_many
    end
    it 'ProcessEstimateとの関係はhas_manyであること' do
      association = MachineType.reflect_on_association(:process_estimates)
      expect(association.macro).to eq :has_many
    end
  end
end
