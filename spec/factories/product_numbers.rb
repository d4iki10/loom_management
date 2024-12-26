FactoryBot.define do
  factory :product_number do
    factory :product_number_pn100 do
      number { "PN-100" }
    end

    factory :product_number_pn200 do
      number { "PN-200" }
    end

    factory :product_number_pn300 do
      number { "PN-300" }
    end

    factory :product_number_pn400 do
      number { "PN-400" }
    end

    factory :product_number_pn500 do
      number { "PN-500" }
    end
  end
end
