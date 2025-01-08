FactoryBot.define do
  factory :machine_assignment do
    # 特定の機械とステータスに対応するファクトリを定義
    factory :machine_assignment_a001_idle do
      association :machine, factory: :machine_a001
      association :machine_status, factory: :machine_status_inactive
      work_process { nil }
    end

    factory :machine_assignment_a002_idle do
      association :machine, factory: :machine_a002
      association :machine_status, factory: :machine_status_inactive
      work_process { nil }
    end

    factory :machine_assignment_a003_idle do
      association :machine, factory: :machine_a003
      association :machine_status, factory: :machine_status_inactive
      work_process { nil }
    end

    factory :machine_assignment_b001_idle do
      association :machine, factory: :machine_b001
      association :machine_status, factory: :machine_status_inactive
      work_process { nil }
    end

    factory :machine_assignment_b002_idle do
      association :machine, factory: :machine_b002
      association :machine_status, factory: :machine_status_inactive
      work_process { nil }
    end

    # 以下、他の機械も同様に定義
    factory :machine_assignment_c001_idle do
      association :machine, factory: :machine_c001
      association :machine_status, factory: :machine_status_inactive
      work_process { nil }
    end

    factory :machine_assignment_c002_idle do
      association :machine, factory: :machine_c002
      association :machine_status, factory: :machine_status_inactive
      work_process { nil }
    end

    factory :machine_assignment_c003_idle do
      association :machine, factory: :machine_c003
      association :machine_status, factory: :machine_status_inactive
      work_process { nil }
    end

    factory :machine_assignment_c004_idle do
      association :machine, factory: :machine_c004
      association :machine_status, factory: :machine_status_inactive
      work_process { nil }
    end

    factory :machine_assignment_d001_idle do
      association :machine, factory: :machine_d001
      association :machine_status, factory: :machine_status_inactive
      work_process { nil }
    end

    factory :machine_assignment_d002_idle do
      association :machine, factory: :machine_d002
      association :machine_status, factory: :machine_status_inactive
      work_process { nil }
    end

    factory :machine_assignment_e001_idle do
      association :machine, factory: :machine_e001
      association :machine_status, factory: :machine_status_inactive
      work_process { nil }
    end

    factory :machine_assignment_e002_idle do
      association :machine, factory: :machine_e002
      association :machine_status, factory: :machine_status_inactive
      work_process { nil }
    end

    factory :machine_assignment_f001_idle do
      association :machine, factory: :machine_f001
      association :machine_status, factory: :machine_status_inactive
      work_process { nil }
    end

    factory :machine_assignment_f002_idle do
      association :machine, factory: :machine_f002
      association :machine_status, factory: :machine_status_inactive
      work_process { nil }
    end

    factory :machine_assignment_f003_idle do
      association :machine, factory: :machine_f003
      association :machine_status, factory: :machine_status_inactive
      work_process { nil }
    end

    factory :machine_assignment_f004_idle do
      association :machine, factory: :machine_f004
      association :machine_status, factory: :machine_status_inactive
      work_process { nil }
    end

    factory :machine_assignment_h001_idle do
      association :machine, factory: :machine_h001
      association :machine_status, factory: :machine_status_inactive
      work_process { nil }
    end

    factory :machine_assignment_h002_idle do
      association :machine, factory: :machine_h002
      association :machine_status, factory: :machine_status_inactive
      work_process { nil }
    end

    factory :machine_assignment_h003_idle do
      association :machine, factory: :machine_h003
      association :machine_status, factory: :machine_status_inactive
      work_process { nil }
    end
  end
end
