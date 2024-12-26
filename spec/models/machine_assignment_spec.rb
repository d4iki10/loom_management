require 'rails_helper'

RSpec.describe MachineAssignment, type: :model do
  describe 'ファクトリ' do
    it '有効なファクトリを持つこと' do
      expect(build(:machine_assignment_a001_idle)).to be_valid
      expect(build(:machine_assignment_a002_idle)).to be_valid
      expect(build(:machine_assignment_a003_idle)).to be_valid
      expect(build(:machine_assignment_b001_idle)).to be_valid
      expect(build(:machine_assignment_b002_idle)).to be_valid
      expect(build(:machine_assignment_c001_idle)).to be_valid
      expect(build(:machine_assignment_c002_idle)).to be_valid
      expect(build(:machine_assignment_c003_idle)).to be_valid
      expect(build(:machine_assignment_c004_idle)).to be_valid
      expect(build(:machine_assignment_d001_idle)).to be_valid
      expect(build(:machine_assignment_d002_idle)).to be_valid
      expect(build(:machine_assignment_e001_idle)).to be_valid
      expect(build(:machine_assignment_e002_idle)).to be_valid
      expect(build(:machine_assignment_f001_idle)).to be_valid
      expect(build(:machine_assignment_f002_idle)).to be_valid
      expect(build(:machine_assignment_f003_idle)).to be_valid
      expect(build(:machine_assignment_f004_idle)).to be_valid
      expect(build(:machine_assignment_h001_idle)).to be_valid
      expect(build(:machine_assignment_h002_idle)).to be_valid
      expect(build(:machine_assignment_h003_idle)).to be_valid
    end
  end

  describe 'アソシエーション' do
    it 'Machineとの関係はbelongs_toであること' do
      association = MachineAssignment.reflect_on_association(:machine)
      expect(association.macro).to eq :belongs_to
    end
    it 'MachineStatusとの関係はbelongs_toであること' do
      association = MachineAssignment.reflect_on_association(:machine_status)
      expect(association.macro).to eq :belongs_to
    end
    it 'WorkProcessとの関係はbelongs_toであること' do
      association = MachineAssignment.reflect_on_association(:work_process)
      expect(association.macro).to eq :belongs_to
    end
  end
end
