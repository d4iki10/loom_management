require 'rails_helper'

RSpec.describe WorkProcess, type: :model do
  describe 'ファクトリ' do
    it '有効なファクトリを持つこと' do
      expect(build(:work_process_a_pn100_c001_fiber)).to be_valid
      expect(build(:work_process_a_pn100_c001_dyeing)).to be_valid
      expect(build(:work_process_a_pn100_c001_weaving_setup)).to be_valid
      expect(build(:work_process_a_pn100_c001_weaving)).to be_valid
      expect(build(:work_process_a_pn100_c001_finishing)).to be_valid
      expect(build(:work_process_b_pn300_c003_fiber)).to be_valid
      expect(build(:work_process_b_pn300_c003_dyeing)).to be_valid
      expect(build(:work_process_b_pn300_c003_weaving_setup)).to be_valid
      expect(build(:work_process_b_pn300_c003_weaving)).to be_valid
      expect(build(:work_process_b_pn300_c003_finishing)).to be_valid
    end
  end

  describe 'バリデーション' do
    it 'orderが必須であること' do
      work_process = build(:work_process_a_pn100_c001_fiber, order: nil)
      expect(work_process).not_to be_valid
      expect(work_process.errors[:order]).to include("must exist")
    end

    it 'work_process_definitionが必須であること' do
      work_process = build(:work_process_a_pn100_c001_fiber, work_process_definition: nil)
      expect(work_process).not_to be_valid
      expect(work_process.errors[:work_process_definition]).to include("must exist")
    end

    it 'work_process_statusが必須であること' do
      work_process = build(:work_process_a_pn100_c001_fiber, work_process_status: nil)
      expect(work_process).not_to be_valid
      expect(work_process.errors[:work_process_status]).to include("must exist")
    end

    it 'start_dateが必須であること' do
      work_process = build(:work_process_a_pn100_c001_fiber, start_date: nil)
      expect(work_process).not_to be_valid
      expect(work_process.errors[:start_date]).to include("can't be blank")
    end

    it 'earliest_estimated_completion_dateが必須であること' do
      work_process = build(:work_process_a_pn100_c001_fiber, earliest_estimated_completion_date: nil)
      expect(work_process).not_to be_valid
      expect(work_process.errors[:earliest_estimated_completion_date]).to include("can't be blank")
    end

    it 'latest_estimated_completion_dateが必須であること' do
      work_process = build(:work_process_a_pn100_c001_fiber, latest_estimated_completion_date: nil)
      expect(work_process).not_to be_valid
      expect(work_process.errors[:latest_estimated_completion_date]).to include("can't be blank")
    end
  end

  describe 'アソシエーション' do
    it 'Orderとの関係はbelongs_toであること' do
      association = WorkProcess.reflect_on_association(:order)
      expect(association.macro).to eq :belongs_to
    end
    it 'WorkProcessDefinitionとの関係はbelongs_toであること' do
      association = WorkProcess.reflect_on_association(:work_process_definition)
      expect(association.macro).to eq :belongs_to
    end
    it 'WorkProcessStatusとの関係はbelongs_toであること' do
      association = WorkProcess.reflect_on_association(:work_process_status)
      expect(association.macro).to eq :belongs_to
    end
    it 'ProcessEstimateとの関係はbelongs_toであること' do
      association = WorkProcess.reflect_on_association(:process_estimate)
      expect(association.macro).to eq :belongs_to
    end
    it 'MachineAssignmentとの関係はhas_manyであること' do
      association = WorkProcess.reflect_on_association(:machine_assignments)
      expect(association.macro).to eq :has_many
    end
    it 'Machineとの関係はhas_manyであること' do
      association = WorkProcess.reflect_on_association(:machines)
      expect(association.macro).to eq :has_many
    end
  end
end
