require 'rails_helper'

RSpec.describe '機屋画面での業務フロー', type: :system do
  before do
    # データベースがリセットされないため今回は使用しない。
    # 一般ユーザー (admin: false)
    # user_sato_hanako = create(:user_sato_hanako)
    # 発注を作成する (order_id: 1 の内容をとってくる)
    # order_a_pn100_c001 = create(:order_a_pn100_c001)
    # 織機を作成する (machine_id: 1 の内容をとってくる)
    # machine_a001 = create(:machine_a001)
  end

  scenario '機屋画面操作' do
    # 1. 一般ユーザーでログインする
    visit login_path
    fill_in 'Email', with: 'bbb@example.com'
    fill_in 'Password', with: 'password'
    click_button 'ログイン'
    # 2. root_path に入ったことを確認
    visit root_path
    expect(page).to have_content 'A001号機'
    expect(page).to have_content 'ー'
    expect(page).to have_content '未稼働'
    # 3. 一覧画面で受注情報を確認
    visit orders_path
    expect(page).to have_content 'PN-10'
    expect(page).to have_content '糸'
    expect(page).to have_content '作業中'
    expect(page).to have_content '2024-12-10'
    # 4. 受注編集で織機を割り当てる
    click_link('edit_button')
    select 'A001号機（ドビー）', from: 'order_machine_assignments_attributes__machine_id'
    click_button '更新'
    # 5. 詳細画面に移動
    expect(page).to have_content 'A001号機'
    expect(page).to have_content '準備中'
    # 6. 「糸」の工程を「作業完了」にする
    click_link('edit_button')
    select '作業完了', from: 'order_work_processes_attributes_0_work_process_status_id'
    click_button '更新'
    # 7. 詳細画面に移動
    expect(page).to have_content '作業完了'
    visit orders_path
    expect(page).to have_content '染色'
    expect(page).to have_content '作業前'
    # 8. Home画面のボタン操作を行う（'作業開始'）
    visit root_path
    click_button '作業開始'
    expect(page).to have_content 'ステータスが正常に更新されました。'
    expect(page).to have_content '製織'
    expect(page).to have_content '稼働中'
    # 9. 1回目は糸〜整経は「作業完了」、製織は「作業中」、織機の稼働状況が「稼働中」になる
    visit orders_path
    click_link('show_button')
    expect(page).to have_content '稼働中'
    # 10. Home画面のボタン操作を行う（'作業開始'）
    visit root_path
    click_button '作業終了'
    expect(page).to have_content 'ステータスが正常に更新されました。'
    expect(page).to have_content 'ー'
    expect(page).to have_content '未稼働'
    # 11. 2回目は糸〜製織は「作業完了」、整理加工は「作業中」、織機の割り当てが外れる
    visit orders_path
    click_link('show_button')
    expect(page).to have_content '現在割り当て中の織機はありません。'
    # 12. 全てを作業完了にする
    click_link('edit_button')
    select '作業完了', from: 'order_work_processes_attributes_4_work_process_status_id'
    click_button '更新'
    expect(page).not_to have_content '作業前'
    expect(page).not_to have_content '作業中'
    expect(page).not_to have_content '確認中'
    # 13. 過去の注文に入ったか確認する
    visit past_orders_orders_path
    expect(page).to have_content '1'
    expect(page).to have_content 'PN-10'
  end
end
