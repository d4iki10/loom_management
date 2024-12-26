require 'rails_helper'

RSpec.describe Machine, type: :model do
  describe 'ファクトリ' do
    it '有効なファクトリを持つこと' do
      expect(build(:machine_a001)).to be_valid
      expect(build(:machine_a002)).to be_valid
      expect(build(:machine_a003)).to be_valid
      expect(build(:machine_b001)).to be_valid
      expect(build(:machine_b002)).to be_valid
      expect(build(:machine_c001)).to be_valid
      expect(build(:machine_c002)).to be_valid
      expect(build(:machine_c003)).to be_valid
      expect(build(:machine_c004)).to be_valid
      expect(build(:machine_d001)).to be_valid
      expect(build(:machine_d002)).to be_valid
      expect(build(:machine_e001)).to be_valid
      expect(build(:machine_e002)).to be_valid
      expect(build(:machine_f001)).to be_valid
      expect(build(:machine_f002)).to be_valid
      expect(build(:machine_f003)).to be_valid
      expect(build(:machine_f004)).to be_valid
      expect(build(:machine_h001)).to be_valid
      expect(build(:machine_h002)).to be_valid
      expect(build(:machine_h003)).to be_valid
    end
  end

  describe 'バリデーション' do
    it '名前が必須であること' do
      machine = build(:machine_a001, name: nil)
      expect(machine).not_to be_valid
      expect(machine.errors[:name]).to include("can't be blank")
    end

    it '名前が一意であること' do
      create(:machine_a001, name: "A001号機")
      duplicate_machine = build(:machine_a002, name: "A001号機")
      expect(duplicate_machine).not_to be_valid
      expect(duplicate_machine.errors[:name]).to include("has already been taken")
    end
  end

  describe 'アソシエーション' do
    it 'MachineTypeとの関係はbelongs_toであること' do
      association = Machine.reflect_on_association(:machine_type)
      expect(association.macro).to eq :belongs_to
    end
    it 'Companyとの関係はbelongs_toであること' do
      association = Machine.reflect_on_association(:company)
      expect(association.macro).to eq :belongs_to
    end
    it 'MachineAssignmentとの関係はhas_manyであること' do
      association = Machine.reflect_on_association(:machine_assignments)
      expect(association.macro).to eq :has_many
    end
  end
end
