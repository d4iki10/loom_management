FactoryBot.define do
  factory :process_estimate do
    # ドビー機種向けのプロセスエスティメート
    factory :process_estimate_fiber_dobby do
      association :work_process_definition, factory: :wp_def_1  # '糸'
      association :machine_type, factory: :machine_type_dobby
      earliest_completion_estimate { 90 }
      latest_completion_estimate { 150 }
      update_date { Date.parse('2024-12-17') }
    end

    factory :process_estimate_dyeing_dobby do
      association :work_process_definition, factory: :wp_def_2  # '染色'
      association :machine_type, factory: :machine_type_dobby
      earliest_completion_estimate { 14 }
      latest_completion_estimate { 21 }
      update_date { Date.parse('2024-12-17') }
    end

    factory :process_estimate_weaving_setup_dobby do
      association :work_process_definition, factory: :wp_def_3  # '整経'
      association :machine_type, factory: :machine_type_dobby
      earliest_completion_estimate { 7 }
      latest_completion_estimate { 14 }
      update_date { Date.parse('2024-12-17') }
    end

    factory :process_estimate_weaving_dobby do
      association :work_process_definition, factory: :wp_def_4  # '製織'
      association :machine_type, factory: :machine_type_dobby
      earliest_completion_estimate { 25 }
      latest_completion_estimate { 30 }
      update_date { Date.parse('2024-12-17') }
    end

    factory :process_estimate_finishing_dobby do
      association :work_process_definition, factory: :wp_def_5  # '整理加工'
      association :machine_type, factory: :machine_type_dobby
      earliest_completion_estimate { 4 }
      latest_completion_estimate { 5 }
      update_date { Date.parse('2024-12-17') }
    end

    # ジャガード機種向けのプロセスエスティメート
    factory :process_estimate_fiber_jacquard do
      association :work_process_definition, factory: :wp_def_1  # '糸'
      association :machine_type, factory: :machine_type_jacquard
      earliest_completion_estimate { 30 }
      latest_completion_estimate { 40 }
      update_date { Date.parse('2024-12-17') }
    end

    factory :process_estimate_dyeing_jacquard do
      association :work_process_definition, factory: :wp_def_2  # '染色'
      association :machine_type, factory: :machine_type_jacquard
      earliest_completion_estimate { 21 }
      latest_completion_estimate { 28 }
      update_date { Date.parse('2024-12-17') }
    end

    factory :process_estimate_weaving_setup_jacquard do
      association :work_process_definition, factory: :wp_def_3  # '整経'
      association :machine_type, factory: :machine_type_jacquard
      earliest_completion_estimate { 14 }
      latest_completion_estimate { 21 }
      update_date { Date.parse('2024-12-17') }
    end

    factory :process_estimate_weaving_jacquard do
      association :work_process_definition, factory: :wp_def_4  # '製織'
      association :machine_type, factory: :machine_type_jacquard
      earliest_completion_estimate { 30 }
      latest_completion_estimate { 40 }
      update_date { Date.parse('2024-12-17') }
    end

    factory :process_estimate_finishing_jacquard do
      association :work_process_definition, factory: :wp_def_5  # '整理加工'
      association :machine_type, factory: :machine_type_jacquard
      earliest_completion_estimate { 4 }
      latest_completion_estimate { 5 }
      update_date { Date.parse('2024-12-17') }
    end
  end
end
