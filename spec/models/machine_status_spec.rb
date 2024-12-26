require 'rails_helper'

RSpec.describe MachineStatus, type: :model do
  describe 'ファクトリ' do
    it '有効なファクトリを持つこと' do
      expect(build(:machine_status_inactive)).to be_valid
      expect(build(:machine_status_preparation)).to be_valid
      expect(build(:machine_status_active)).to be_valid
      expect(build(:machine_status_under_maintenance)).to be_valid
    end
  end

  describe 'バリデーション' do
    it '名前が必須であること' do
      machine_status = build(:machine_status_inactive, name: nil)
      expect(machine_status).not_to be_valid
      expect(machine_status.errors[:name]).to include("can't be blank")
    end

    it '名前が一意であること' do
      create(:machine_status_inactive, name: "未稼働")
      duplicate_status = build(:machine_status_preparation, name: "未稼働")
      expect(duplicate_status).not_to be_valid
      expect(duplicate_status.errors[:name]).to include("has already been taken")
    end
  end

  describe 'アソシエーション' do
    it 'MachineAssignmentとの関係はhas_manyであること' do
      association = MachineStatus.reflect_on_association(:machine_assignments)
      expect(association.macro).to eq :has_many
    end
  end
end
