FactoryBot.define do
  factory :order do
    # 機屋AのPN-10 C-001の発注
    factory :order_a_pn100_c001 do
      association :company, factory: :hataya_a_company
      association :product_number, factory: :product_number_pn100
      association :color_number, factory: :color_number_c001
      roll_count { 100 }
      quantity { 1000 }
      start_date { Date.parse('2024-12-10') }
    end

    # 機屋BのPN-30 C-003の発注
    factory :order_b_pn300_c003 do
      association :company, factory: :hataya_b_company
      association :product_number, factory: :product_number_pn300
      association :color_number, factory: :color_number_c003
      roll_count { 50 }
      quantity { 500 }
      start_date { Date.parse('2024-12-10') }
    end
  end
end
