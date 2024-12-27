FactoryBot.define do
  factory :work_process do
    # 機屋AのPN-100 C-001の作業工程
    factory :work_process_a_pn100_c001_fiber do
      association :order, factory: :order_a_pn100_c001
      association :work_process_definition, factory: :wp_def_1  # '糸'
      association :work_process_status, factory: :wps_status_active
      association :process_estimate, factory: :process_estimate_fiber_dobby
      start_date { Date.parse('2024-12-10') }
      earliest_estimated_completion_date { Date.parse('2025-03-10') }
      latest_estimated_completion_date { Date.parse('2025-05-09') }
      factory_estimated_completion_date { nil }
      actual_completion_date { nil }
    end

    factory :work_process_a_pn100_c001_dyeing do
      association :order, factory: :order_a_pn100_c001
      association :work_process_definition, factory: :wp_def_2  # '染色'
      association :work_process_status, factory: :wps_status_preparation
      association :process_estimate, factory: :process_estimate_dyeing_dobby
      start_date { Date.parse('2025-03-10') }
      earliest_estimated_completion_date { Date.parse('2025-03-24') }
      latest_estimated_completion_date { Date.parse('2025-03-31') }
      factory_estimated_completion_date { nil }
      actual_completion_date { nil }
    end

    factory :work_process_a_pn100_c001_weaving_setup do
      association :order, factory: :order_a_pn100_c001
      association :work_process_definition, factory: :wp_def_3  # '整経'
      association :work_process_status, factory: :wps_status_preparation
      association :process_estimate, factory: :process_estimate_weaving_setup_dobby
      start_date { Date.parse('2025-03-24') }
      earliest_estimated_completion_date { Date.parse('2025-03-31') }
      latest_estimated_completion_date { Date.parse('2025-04-07') }
      factory_estimated_completion_date { nil }
      actual_completion_date { nil }
    end

    factory :work_process_a_pn100_c001_weaving do
      association :order, factory: :order_a_pn100_c001
      association :work_process_definition, factory: :wp_def_4  # '製織'
      association :work_process_status, factory: :wps_status_preparation
      association :process_estimate, factory: :process_estimate_weaving_dobby
      start_date { Date.parse('2025-03-31') }
      earliest_estimated_completion_date { Date.parse('2025-04-25') }
      latest_estimated_completion_date { Date.parse('2025-04-30') }
      factory_estimated_completion_date { nil }
      actual_completion_date { nil }
    end

    factory :work_process_a_pn100_c001_finishing do
      association :order, factory: :order_a_pn100_c001
      association :work_process_definition, factory: :wp_def_5  # '整理加工'
      association :work_process_status, factory: :wps_status_preparation
      association :process_estimate, factory: :process_estimate_finishing_dobby
      start_date { Date.parse('2025-04-28') }
      earliest_estimated_completion_date { Date.parse('2025-05-02') }
      latest_estimated_completion_date { Date.parse('2025-05-03') }
      factory_estimated_completion_date { nil }
      actual_completion_date { nil }
    end

    # 機屋BのPN-300 C-003の作業工程
    factory :work_process_b_pn300_c003_fiber do
      association :order, factory: :order_b_pn300_c003
      association :work_process_definition, factory: :wp_def_1  # '糸'
      association :work_process_status, factory: :wps_status_preparation
      association :process_estimate, factory: :process_estimate_fiber_jacquard
      start_date { Date.parse('2024-12-10') }
      earliest_estimated_completion_date { Date.parse('2025-01-09') }
      latest_estimated_completion_date { Date.parse('2025-01-19') }
      factory_estimated_completion_date { nil }
      actual_completion_date { nil }
    end

    factory :work_process_b_pn300_c003_dyeing do
      association :order, factory: :order_b_pn300_c003
      association :work_process_definition, factory: :wp_def_2  # '染色'
      association :work_process_status, factory: :wps_status_preparation
      association :process_estimate, factory: :process_estimate_dyeing_jacquard
      start_date { Date.parse('2025-01-09') }
      earliest_estimated_completion_date { Date.parse('2025-01-30') }
      latest_estimated_completion_date { Date.parse('2025-02-06') }
      factory_estimated_completion_date { nil }
      actual_completion_date { nil }
    end

    factory :work_process_b_pn300_c003_weaving_setup do
      association :order, factory: :order_b_pn300_c003
      association :work_process_definition, factory: :wp_def_3  # '整経'
      association :work_process_status, factory: :wps_status_preparation
      association :process_estimate, factory: :process_estimate_weaving_setup_jacquard
      start_date { Date.parse('2025-01-30') }
      earliest_estimated_completion_date { Date.parse('2025-02-13') }
      latest_estimated_completion_date { Date.parse('2025-02-20') }
      factory_estimated_completion_date { nil }
      actual_completion_date { nil }
    end

    factory :work_process_b_pn300_c003_weaving do
      association :order, factory: :order_b_pn300_c003
      association :work_process_definition, factory: :wp_def_4  # '製織'
      association :work_process_status, factory: :wps_status_preparation
      association :process_estimate, factory: :process_estimate_weaving_jacquard
      start_date { Date.parse('2025-02-13') }
      earliest_estimated_completion_date { Date.parse('2025-03-15') }
      latest_estimated_completion_date { Date.parse('2025-03-25') }
      factory_estimated_completion_date { nil }
      actual_completion_date { nil }
    end

    factory :work_process_b_pn300_c003_finishing do
      association :order, factory: :order_b_pn300_c003
      association :work_process_definition, factory: :wp_def_5  # '整理加工'
      association :work_process_status, factory: :wps_status_preparation
      association :process_estimate, factory: :process_estimate_finishing_jacquard
      start_date { Date.parse('2025-03-17') }
      earliest_estimated_completion_date { Date.parse('2025-03-21') }
      latest_estimated_completion_date { Date.parse('2025-03-22') }
      factory_estimated_completion_date { nil }
      actual_completion_date { nil }
    end
  end
end
