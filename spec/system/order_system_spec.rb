# spec/system/order_system_spec.rb
require 'rails_helper'

RSpec.describe '機屋画面での業務フロー', type: :system do
  before do
    # 必要なデータを作成
    # 全削除(推奨しません)
    WorkProcess.destroy_all
    Order.destroy_all
    MachineAssignment.destroy_all
    Machine.destroy_all
    User.destroy_all
    Company.destroy_all

    # ユーザーの作成
    @admin_user = FactoryBot.create(:user_yamada_taro)    # 管理者ユーザー
    @regular_user = FactoryBot.create(:user_sato_hanako) # 一般ユーザー

    # マシンの作成
    @machine_a001 = FactoryBot.create(:machine_a001)
    @machine_a002 = FactoryBot.create(:machine_a002)
    # 必要に応じて他のマシンも作成

    # マシンステータスの作成
    @machine_status_inactive = FactoryBot.create(:machine_status_inactive)
    @machine_status_preparation = FactoryBot.create(:machine_status_preparation)
    @machine_status_active = FactoryBot.create(:machine_status_active)
    @machine_status_under_maintenance = FactoryBot.create(:machine_status_under_maintenance)

    # プロセスステータスの作成
    @wps_status_preparation = FactoryBot.create(:wps_status_preparation)
    @wps_status_active = FactoryBot.create(:wps_status_active)
    @wps_status_completed = FactoryBot.create(:wps_status_completed)
    @wps_status_check = FactoryBot.create(:wps_status_check)

    # プロセス定義の作成
    @wp_def_1 = FactoryBot.create(:wp_def_1) # '糸'
    @wp_def_2 = FactoryBot.create(:wp_def_2) # '染色'
    @wp_def_3 = FactoryBot.create(:wp_def_3) # '整経'
    @wp_def_4 = FactoryBot.create(:wp_def_4) # '製織'
    @wp_def_5 = FactoryBot.create(:wp_def_5) # '整理加工'

    # プロセスエスティメートの作成
    @process_estimate_fiber_dobby = FactoryBot.create(:process_estimate_fiber_dobby)
    @process_estimate_dyeing_dobby = FactoryBot.create(:process_estimate_dyeing_dobby)
    @process_estimate_weaving_setup_dobby = FactoryBot.create(:process_estimate_weaving_setup_dobby)
    @process_estimate_weaving_dobby = FactoryBot.create(:process_estimate_weaving_dobby)
    @process_estimate_finishing_dobby = FactoryBot.create(:process_estimate_finishing_dobby)

    # 注文の作成
    @order_a_pn100_c001 = FactoryBot.create(:order_a_pn100_c001)

    # 作業プロセスの作成
    FactoryBot.create(:work_process_a_pn100_c001_fiber, order: @order_a_pn100_c001)
    FactoryBot.create(:work_process_a_pn100_c001_dyeing, order: @order_a_pn100_c001)
    FactoryBot.create(:work_process_a_pn100_c001_weaving_setup, order: @order_a_pn100_c001)
    FactoryBot.create(:work_process_a_pn100_c001_weaving, order: @order_a_pn100_c001)
    FactoryBot.create(:work_process_a_pn100_c001_finishing, order: @order_a_pn100_c001)

    # マシンアサインメントの作成
    FactoryBot.create(:machine_assignment_a001_idle, machine: @machine_a001, machine_status: @machine_status_inactive)
    # 必要に応じて他のマシンアサインメントも作成

    # その他、必要なデータをここに追加
  end

  scenario '機屋画面操作' do
    # 管理者ユーザーでログイン
    login_as_admin('aaa@example.com', 'password')

    # 管理者としての操作
    visit admin_orders_path
    expect(page).to have_content 'PN-100'
    expect(page).to have_content '糸'
    expect(page).to have_content '作業中'
    expect(page).to have_content '2024-12-10'
    click_button 'ログアウト'

    # 一般ユーザーでログイン
    login_as_user('bbb@example.com', 'password')

    # 一般ユーザーとしての操作
    visit root_path
    expect(page).to have_content 'A001号機'
    expect(page).to have_content 'ー'
    expect(page).to have_content '未稼働'

    visit orders_path
    expect(page).to have_content 'PN-100'
    expect(page).to have_content '糸'
    expect(page).to have_content '作業中'
    expect(page).to have_content '2024-12-10'

    # 受注編集で織機を割り当てる
    within first('.order') do
      click_link 'edit_button'
    end
    select 'A001号機（ドビー）', from: 'order_machine_assignments_attributes_0_machine_id'
    click_button '更新'

    # 詳細画面に移動して確認
    expect(page).to have_content 'A001号機'
    expect(page).to have_content '準備中'

    # 「糸」の工程を「作業完了」にする
    within first('.order_work_process') do
      click_link 'edit_button'
    end
    select '作業完了', from: 'order_work_processes_attributes_0_work_process_status_id'
    click_button '更新'

    # 作業完了を確認
    expect(page).to have_content '作業完了'

    visit orders_path
    expect(page).to have_content '染色'
    expect(page).to have_content '作業前'

    # Home画面のボタン操作「作業開始」
    visit root_path
    click_button '作業開始'
    expect(page).to have_content 'ステータスが正常に更新されました。'
    expect(page).to have_content '製織'
    expect(page).to have_content '稼働中'

    # 一回目の状態確認
    visit orders_path
    within first('.order') do
      click_link 'show_button'
    end
    expect(page).to have_content '稼働中'

    # Home画面のボタン操作「作業終了」
    visit root_path
    click_button '作業終了'
    expect(page).to have_content 'ステータスが正常に更新されました。'
    expect(page).to have_content 'ー'
    expect(page).to have_content '未稼働'

    # 二回目の状態確認
    visit orders_path
    within first('.order') do
      click_link 'show_button'
    end
    expect(page).to have_content '現在割り当て中の織機はありません。'

    # 全てを作業完了にする
    within first('.order') do
      click_link 'edit_button'
    end
    select '作業完了', from: 'order_work_processes_attributes_4_work_process_status_id'
    click_button '更新'

    expect(page).not_to have_content '作業前'
    expect(page).not_to have_content '作業中'
    expect(page).not_to have_content '確認中'

    # 過去の注文に入ったか確認
    visit past_orders_orders_path
    expect(page).to have_content '1'
    expect(page).to have_content 'PN-100'
  end

  private

  def login_as_admin(email, password)
    visit login_path
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    click_button 'ログイン'
  end

  def login_as_user(email, password)
    visit login_path
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    click_button 'ログイン'
  end
end
