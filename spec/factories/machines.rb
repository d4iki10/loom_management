FactoryBot.define do
  factory :machine do
    factory :machine_a001 do
      name { 'A001号機' }
      association :machine_type, factory: :machine_type_dobby
      association :company, factory: :hataya_a_company
    end

    factory :machine_a002 do
      name { 'A002号機' }
      association :machine_type, factory: :machine_type_dobby
      association :company, factory: :hataya_a_company
    end

    factory :machine_a003 do
      name { 'A003号機' }
      association :machine_type, factory: :machine_type_jacquard
      association :company, factory: :hataya_a_company
    end

    factory :machine_b001 do
      name { 'B001号機' }
      association :machine_type, factory: :machine_type_dobby
      association :company, factory: :hataya_b_company
    end

    factory :machine_b002 do
      name { 'B002号機' }
      association :machine_type, factory: :machine_type_jacquard
      association :company, factory: :hataya_b_company
    end

    factory :machine_c001 do
      name { 'C001号機' }
      association :machine_type, factory: :machine_type_dobby
      association :company, factory: :hataya_c_company
    end

    factory :machine_c002 do
      name { 'C002号機' }
      association :machine_type, factory: :machine_type_dobby
      association :company, factory: :hataya_c_company
    end

    factory :machine_c003 do
      name { 'C003号機' }
      association :machine_type, factory: :machine_type_jacquard
      association :company, factory: :hataya_c_company
    end

    factory :machine_c004 do
      name { 'C004号機' }
      association :machine_type, factory: :machine_type_dobby
      association :company, factory: :hataya_c_company
    end

    factory :machine_d001 do
      name { 'D001号機' }
      association :machine_type, factory: :machine_type_jacquard
      association :company, factory: :hataya_d_company
    end

    factory :machine_d002 do
      name { 'D002号機' }
      association :machine_type, factory: :machine_type_dobby
      association :company, factory: :hataya_d_company
    end

    factory :machine_e001 do
      name { 'E001号機' }
      association :machine_type, factory: :machine_type_dobby
      association :company, factory: :hataya_e_company
    end

    factory :machine_e002 do
      name { 'E002号機' }
      association :machine_type, factory: :machine_type_dobby
      association :company, factory: :hataya_e_company
    end

    factory :machine_f001 do
      name { 'F001号機' }
      association :machine_type, factory: :machine_type_dobby
      association :company, factory: :hataya_f_company
    end

    factory :machine_f002 do
      name { 'F002号機' }
      association :machine_type, factory: :machine_type_jacquard
      association :company, factory: :hataya_f_company
    end

    factory :machine_f003 do
      name { 'F003号機' }
      association :machine_type, factory: :machine_type_dobby
      association :company, factory: :hataya_f_company
    end

    factory :machine_f004 do
      name { 'F004号機' }
      association :machine_type, factory: :machine_type_dobby
      association :company, factory: :hataya_f_company
    end

    factory :machine_h001 do
      name { 'H001号機' }
      association :machine_type, factory: :machine_type_jacquard
      association :company, factory: :hataya_h_company
    end

    factory :machine_h002 do
      name { 'H002号機' }
      association :machine_type, factory: :machine_type_dobby
      association :company, factory: :hataya_h_company
    end

    factory :machine_h003 do
      name { 'H003号機' }
      association :machine_type, factory: :machine_type_jacquard
      association :company, factory: :hataya_h_company
    end
  end
end
