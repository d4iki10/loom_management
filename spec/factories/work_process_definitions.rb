FactoryBot.define do
  factory :work_process_definition do
    sequence(:sequence) { |n| n } # ユニークな値を自動生成

    factory :wp_def_1 do
      name { "糸" }
    end

    factory :wp_def_2 do
      name { "染色" }
    end

    factory :wp_def_3 do
      name { "整経" }
    end

    factory :wp_def_4 do
      name { "製織" }
    end

    factory :wp_def_5 do
      name { "整理加工" }
    end
  end
end
