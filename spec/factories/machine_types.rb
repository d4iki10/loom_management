FactoryBot.define do
  factory :machine_type do
    factory :machine_type_dobby do
      name { "ドビー" }
    end

    factory :machine_type_jacquard do
      name { "ジャガード" }
    end
  end
end
