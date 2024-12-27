require 'rails_helper'

RSpec.describe WorkProcessStatus, type: :model do
  describe 'ファクトリ' do
    it '有効なファクトリを持つこと' do
      expect(build(:wps_status_preparation)).to be_valid
      expect(build(:wps_status_active)).to be_valid
      expect(build(:wps_status_completed)).to be_valid
      expect(build(:wps_status_check)).to be_valid
    end
  end

  describe 'バリデーション' do
    it '名前が必須であること' do
      wps = build(:wps_status_preparation, name: nil)
      expect(wps).not_to be_valid
      expect(wps.errors[:name]).to include("can't be blank")
    end

    it '名前が一意であること' do
      create(:wps_status_preparation, name: "作業前")
      duplicate_wps = build(:wps_status_active, name: "作業前")
      expect(duplicate_wps).not_to be_valid
      expect(duplicate_wps.errors[:name]).to include("has already been taken")
    end
  end

  describe 'アソシエーション' do
    it 'WorkProcessとの関係はhas_manyであること' do
      association = WorkProcessStatus.reflect_on_association(:work_processes)
      expect(association.macro).to eq :has_many
    end
  end
end
