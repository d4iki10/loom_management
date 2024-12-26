FactoryBot.define do
  factory :work_process_definition do
    factory :wp_def_1 do
      name { "糸" }
      sequence(:sequence) { 1 }
    end

    factory :wp_def_2 do
      name { "染色" }
      sequence(:sequence) { 2 }
    end

    factory :wp_def_3 do
      name { "整経" }
      sequence(:sequence) { 3 }
    end

    factory :wp_def_4 do
      name { "製織" }
      sequence(:sequence) { 4 }
    end

    factory :wp_def_5 do
      name { "整理加工" }
      sequence(:sequence) { 5 }
    end
  end
end
