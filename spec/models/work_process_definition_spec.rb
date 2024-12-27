require 'rails_helper'

RSpec.describe WorkProcessDefinition, type: :model do
  describe 'ファクトリ' do
    it '有効なファクトリを持つこと' do
      expect(build(:wp_def_1)).to be_valid
      expect(build(:wp_def_2)).to be_valid
      expect(build(:wp_def_3)).to be_valid
      expect(build(:wp_def_4)).to be_valid
      expect(build(:wp_def_5)).to be_valid
    end
  end

  describe 'バリデーション' do
    it '名前が必須であること' do
      wp_def = build(:wp_def_1, name: nil)
      expect(wp_def).not_to be_valid
      expect(wp_def.errors[:name]).to include("can't be blank")
    end

    it 'シーケンスが必須であること' do
      wp_def = build(:wp_def_1, sequence: nil)
      expect(wp_def).not_to be_valid
      expect(wp_def.errors[:sequence]).to include("can't be blank")
    end

    it 'シーケンスが一意であること' do
      create(:wp_def_1, sequence: 1)
      duplicate_wp_def = build(:wp_def_2, sequence: 1)
      expect(duplicate_wp_def).not_to be_valid
      expect(duplicate_wp_def.errors[:sequence]).to include("has already been taken")
    end
  end

  describe 'アソシエーション' do
    it 'ProcessEstimateとの関係はhas_manyであること' do
      association = WorkProcessDefinition.reflect_on_association(:process_estimates)
      expect(association.macro).to eq :has_many
    end
    it 'WorkProcessとの関係はhas_manyであること' do
      association = WorkProcessDefinition.reflect_on_association(:work_processes)
      expect(association.macro).to eq :has_many
    end
  end
end
