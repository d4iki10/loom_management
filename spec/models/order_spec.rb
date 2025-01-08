require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'ファクトリ' do
    it '有効なファクトリを持つこと' do
      expect(build(:order_a_pn100_c001)).to be_valid
      expect(build(:order_b_pn300_c003)).to be_valid
    end
  end

  describe 'バリデーション' do
    it '会社が必須であること' do
      order = build(:order_a_pn100_c001, company: nil)
      expect(order).not_to be_valid
      expect(order.errors[:company]).to include("must exist")
    end

    it 'product_numberが必須であること' do
      order = build(:order_a_pn100_c001, product_number: nil)
      expect(order).not_to be_valid
      expect(order.errors[:product_number]).to include("must exist")
    end

    it 'color_numberが必須であること' do
      order = build(:order_a_pn100_c001, color_number: nil)
      expect(order).not_to be_valid
      expect(order.errors[:color_number]).to include("must exist")
    end

    it 'roll_countが必須であること' do
      order = build(:order_a_pn100_c001, roll_count: nil)
      expect(order).not_to be_valid
      expect(order.errors[:roll_count]).to include("can't be blank")
    end

    it 'quantityが必須であること' do
      order = build(:order_a_pn100_c001, quantity: nil)
      expect(order).not_to be_valid
      expect(order.errors[:quantity]).to include("can't be blank")
    end
  end

  describe 'アソシエーション' do
    it 'Companyとの関係はbelongs_toであること' do
      association = Order.reflect_on_association(:company)
      expect(association.macro).to eq :belongs_to
    end
    it 'ProductNumberとの関係はbelongs_toであること' do
      association = Order.reflect_on_association(:product_number)
      expect(association.macro).to eq :belongs_to
    end
    it 'ColorNumberとの関係はbelongs_toであること' do
      association = Order.reflect_on_association(:color_number)
      expect(association.macro).to eq :belongs_to
    end
    it 'WorkProcessとの関係はhas_manyであること' do
      association = Order.reflect_on_association(:work_processes)
      expect(association.macro).to eq :has_many
    end
    it 'MachineAssignmentとの関係はhas_manyであること' do
      association = Order.reflect_on_association(:machine_assignments)
      expect(association.macro).to eq :has_many
    end
  end
end
