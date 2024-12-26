FactoryBot.define do
  factory :work_process_status do
    factory :wps_status_preparation do
      name { "作業前" }
    end

    factory :wps_status_active do
      name { "作業中" }
    end

    factory :wps_status_completed do
      name { "作業完了" }
    end

    factory :wps_status_check do
      name { "確認中" }
    end
  end
end
