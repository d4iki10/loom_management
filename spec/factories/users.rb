FactoryBot.define do
  factory :user do
    # 各シードユーザーに対応する具体的なファクトリ
    factory :user_yamada_taro do
      name { '山田太郎' }
      email { 'aaa@example.com' }
      phone_number { '000-0000-0000' }
      association :company, factory: :tonya_company
      admin { true }
      password { 'password' }
      password_confirmation { 'password' }
    end

    factory :user_sato_hanako do
      name { '佐藤花子' }
      email { 'bbb@example.com' }
      phone_number { '000-0000-0001' }
      association :company, factory: :hataya_a_company
      admin { false }
      password { 'password' }
      password_confirmation { 'password' }
    end

    factory :user_suzuki_ichiro do
      name { '鈴木一郎' }
      email { 'ccc@example.com' }
      phone_number { '000-0000-0002' }
      association :company, factory: :hataya_b_company
      admin { false }
      password { 'password' }
      password_confirmation { 'password' }
    end

    factory :user_otani_shohei do
      name { '大谷翔平' }
      email { 'ddd@example.com' }
      phone_number { '000-0000-0003' }
      association :company, factory: :hataya_c_company
      admin { false }
      password { 'password' }
      password_confirmation { 'password' }
    end

    factory :user_tanaka_ken do
      name { '田中健' }
      email { 'eee@example.com' }
      phone_number { '000-0000-0004' }
      association :company, factory: :hataya_d_company
      admin { false }
      password { 'password' }
      password_confirmation { 'password' }
    end

    factory :user_nakamura_misaki do
      name { '中村美咲' }
      email { 'fff@example.com' }
      phone_number { '000-0000-0005' }
      association :company, factory: :hataya_e_company
      admin { false }
      password { 'password' }
      password_confirmation { 'password' }
    end

    factory :user_kobayashi_makoto do
      name { '小林誠' }
      email { 'ggg@example.com' }
      phone_number { '000-0000-0006' }
      association :company, factory: :hataya_f_company
      admin { false }
      password { 'password' }
      password_confirmation { 'password' }
    end

    factory :user_takahashi_naoko do
      name { '高橋直子' }
      email { 'hhh@example.com' }
      phone_number { '000-0000-0007' }
      association :company, factory: :hataya_g_company
      admin { false }
      password { 'password' }
      password_confirmation { 'password' }
    end

    factory :user_ito_sho do
      name { '伊藤翔' }
      email { 'iii@example.com' }
      phone_number { '000-0000-0008' }
      association :company, factory: :hataya_h_company
      admin { false }
      password { 'password' }
      password_confirmation { 'password' }
    end
  end
end
