require 'rails_helper'

RSpec.describe ProcessEstimate, type: :model do
  describe 'ファクトリ' do
    it '有効なファクトリを持つこと' do
      expect(build(:process_estimate_fiber_dobby)).to be_valid
      expect(build(:process_estimate_dyeing_dobby)).to be_valid
      expect(build(:process_estimate_weaving_setup_dobby)).to be_valid
      expect(build(:process_estimate_weaving_dobby)).to be_valid
      expect(build(:process_estimate_finishing_dobby)).to be_valid
      expect(build(:process_estimate_fiber_jacquard)).to be_valid
      expect(build(:process_estimate_dyeing_jacquard)).to be_valid
      expect(build(:process_estimate_weaving_setup_jacquard)).to be_valid
      expect(build(:process_estimate_weaving_jacquard)).to be_valid
      expect(build(:process_estimate_finishing_jacquard)).to be_valid
    end
  end

  describe 'バリデーション' do
    it 'machine_typeが必須であること' do
      process_estimate = build(:process_estimate_fiber_dobby, machine_type: nil)
      expect(process_estimate).not_to be_valid
      expect(process_estimate.errors[:machine_type]).to include("must exist")
    end

    it 'work_process_definitionが必須であること' do
      process_estimate = build(:process_estimate_fiber_dobby, work_process_definition: nil)
      expect(process_estimate).not_to be_valid
      expect(process_estimate.errors[:work_process_definition]).to include("must exist")
    end

    it 'earliest_completion_estimateが必須であること' do
      process_estimate = build(:process_estimate_fiber_dobby, earliest_completion_estimate: nil)
      expect(process_estimate).not_to be_valid
      expect(process_estimate.errors[:earliest_completion_estimate]).to include("can't be blank")
    end

    it 'latest_completion_estimateが必須であること' do
      process_estimate = build(:process_estimate_fiber_dobby, latest_completion_estimate: nil)
      expect(process_estimate).not_to be_valid
      expect(process_estimate.errors[:latest_completion_estimate]).to include("can't be blank")
    end
  end

  describe 'アソシエーション' do
    it 'MachineTypeとの関係はbelongs_toであること' do
      association = ProcessEstimate.reflect_on_association(:machine_type)
      expect(association.macro).to eq :belongs_to
    end
    it 'WorkProcessDefinitionとの関係はbelongs_toであること' do
      association = ProcessEstimate.reflect_on_association(:work_process_definition)
      expect(association.macro).to eq :belongs_to
    end
    it 'WorkProcessとの関係はhas_manyであること' do
      association = ProcessEstimate.reflect_on_association(:work_processes)
      expect(association.macro).to eq :has_many
    end
  end
end
