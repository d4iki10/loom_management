FactoryBot.define do
  factory :machine_status do
    factory :machine_status_inactive do
      name { "未稼働" }
    end

    factory :machine_status_preparation do
      name { "準備中" }
    end

    factory :machine_status_active do
      name { "稼働中" }
    end

    factory :machine_status_under_maintenance do
      name { "故障中" }
    end
  end
end
