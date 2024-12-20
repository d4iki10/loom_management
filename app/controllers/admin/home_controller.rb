class Admin::HomeController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_company, only: [:show]

  def index
    @orders = Order.all
    @no_orders_message = "現在、受注はありません。" unless @orders.exists?

    # WorkProcessにMachineAssignmentがないOrderを取得
    @orders_needing_assignment = @orders.select do |order|
      !order.work_processes.any? { |wp| wp.machine_assignments.any? }
    end

    # デバッグ用に binding.irb を挿入
    # binding.irb if @orders_needing_assignment.any?

    if @orders_needing_assignment.any?
      flash.now[:alert] = build_flash_message(@orders_needing_assignment)
    end

    @companies = Company.includes(machines: :machine_assignments)
                        .where.not(id: 1)
                        .map do |company|
      machines = company.machines

      # 各Machineの最新の稼働状況を取得
      status_counts = {
        "未稼働" => 0,
        "準備中" => 0,
        "稼働中" => 0,
        "故障中" => 0
      }

      machines.each do |machine|
        latest_status = machine.latest_machine_status&.name
        status_counts[latest_status] += 1 if status_counts.key?(latest_status)
      end

      {
        id: company.id,
        name: company.name,
        inactive_count: status_counts["未稼働"],
        preparation_count: status_counts["準備中"],
        active_count: status_counts["稼働中"],
        broken_count: status_counts["故障中"]
      }
    end
  end

  def show
    @machines = @company.machines.includes(machine_assignments: :machine_status).order(:id).uniq

    # 最新の情報を各機械ごとに取得
    @machines_with_details = @machines.map do |machine|
      {
        machine: machine,
        latest_process: machine.latest_work_process,
        latest_status: machine.latest_work_process_status,
        latest_completion_date: machine.latest_factory_estimated_completion_date,
        latest_assignment: machine.latest_machine_assignment
      }
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to admin_root_path, alert: "指定された会社が見つかりませんでした。"
  end

  private

  def authenticate_admin!
    # 管理者認証のロジックをここに追加
    redirect_to root_path unless current_user&.admin?
  end

  def set_company
    @company = Company.find(params[:id])
  end

  # ↓↓ フラッシュメッセージを出すのに必要なメソッド ↓↓
  def build_flash_message(orders)
    orders = Order.all
    # 基本となるRelationを定義（work_processesとmachine_assignmentsを左外部結合）
    base_relation = orders.left_outer_joins(:machine_assignments)
    # 条件1: machine_assignmentsが存在しない
    condition_no_assignment = base_relation.where(machine_assignments: { id: nil })
    # 条件2: machine_assignmentsが存在してもmachine_idがnil
    condition_machine_id_nil = base_relation.where(machine_assignments: { machine_id: nil })
    # 条件1または条件2を満たすOrderを取得
    problematic_orders = condition_no_assignment.or(condition_machine_id_nil).distinct.order(company_id: :asc)
    grouped = problematic_orders.group_by(&:id).count

    # フラッシュメッセージを生成
    message = problematic_orders.map do |order|
      link = "会社名: #{order.company.name}, 受注 (ID: #{order.id}), " +
             "詳しくは #{view_context.link_to('編集', edit_admin_order_path(order), class: 'text-blue-500 underline')} や " +
             "#{view_context.link_to('詳細', admin_order_path(order), class: 'text-blue-500 underline')} をご確認ください。"
      "<li>#{link}</li>"
    end.join("<br>").html_safe

    flash.now[:alert] = <<-HTML.html_safe
      <strong>織機の割り当てができていない発注が #{grouped} 件あります。</strong>
      <ul class="text-red-700 list-disc ml-4 px-4 py-2">
        #{message}
      </ul>
    HTML
  end
end
