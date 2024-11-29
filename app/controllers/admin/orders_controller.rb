class Admin::OrdersController < ApplicationController
before_action :order_params, only: [:create,  :update]
before_action :set_order, only: [:edit, :show, :update, :destroy, :edit_work_processes, :update_work_processes]
before_action :work_process_params, only: [:create, :update]
# before_action :process_estimate_params, only: [:create, :update]
before_action :admin_user

  def index
    @orders = Order.includes(work_processes: [:work_process_definition, :work_process_status, process_estimate: :machine_type])

    # 各注文に対して現在作業中の作業工程を取得
    @current_work_processes = {}
    @orders.each do |order|
      if order.work_processes.any?
        @current_work_processes[order.id] = order.work_processes.current_work_process
      else
        @current_work_processes[order.id] = nil
      end
    end
  end

  def new
    @order = Order.new
  end

  def create
    # orderテーブル以外を除外してorderインスタンス作成
    @order = Order.new(order_params)

    start_date = work_process_params[:start_date]
    machine_type_id = work_process_params[:process_estimate][:machine_type_id].to_i


    if machine_type_id == 1
      # earliest_estimated_completion_dateの値を定義
      # earliest_estimated_completion_date = start_date + "日数を返す関数"

      # 5個のwork_processインスタンスを作成
      dobby_workprocesses = WorkProcess.dobby_initial_processes_list(start_date)

      updated_dobby_workprocesses = WorkProcess.update_dobby_deadline(dobby_workprocesses, machine_type_id, start_date)
      # 関連付け
      # binding.irb
      @order.work_processes.build(updated_dobby_workprocesses)
      binding.irb
      @order.save


      redirect_to admin_orders_path, notice: "注文が作成されました"

    elsif machine_type_id == 2

      jacquard_workprocesses = WorkProcess.jacquard_initial_processes_list(start_date)

      updated_jacquard_workprocesses = WorkProcess.update_jacquard_deadline(jacquard_workprocesses, machine_type_id, start_date)

      # 関連付け
      @order.work_processes.build(updated_jacquard_workprocesses)
      @order.save

      redirect_to admin_orders_path, notice: "注文が作成されました"
    end

    # machine_type_idをナレッジに保存
    # @order.work_processes.each do |work_process|
    #   work_process.earliest_estimated_completion_date = Date.today
    #   work_process.latest_estimated_completion_date = Date.today
    #   unless work_process.save
    #     redirect_to admin_orders_path, alert: "作業工程の保存に失敗しました" and return
    #   end
    # binding.irb
    # ナレッジが計算される(初回はそのまま表示)
    # @order.save
    # redirect_to admin_orders_path, notice: "注文が作成されました"

    # # orderの子オブジェクトのworkProcessインスタンス作成
    # @order.work_processes.build(
    #   WorkProcess.initial_processes_list(order_params[:start_date]).map {|process| {**process, process_estimates_id: 1}}
    # )
  end

  def show
    @work_process = @order.work_processes.joins(:work_process_definition)
    .order("work_process_definitions.sequence ASC")
  end

  def edit
    if @order.nil?
      Rails.logger.debug "注文が見つかりません"
      raise "注文が見つかりません"
    end
  end

  def update
    if @order.update(order_params)
      # 国際化（i18n）
      # ja.yml に定義したフラッシュメッセージに翻訳
      # binding.irb
      flash[:notice] = "発注が更新されました"


      redirect_to admin_order_path(@order)
    else
      flash.now[:alert] = @order.errors.full_messages.join(", ") # エラーメッセージを追加
      render :edit
    end
  end

  # 作業工程の編集
  def edit_work_processes
    # 必要なデータを渡す
    @work_processes = @order.work_processes.joins(:work_process_definition).order("work_process_definitions.sequence ASC")
  end

  # 作業工程の更新
  def update_work_processes
    # strongparameterで許可されたフォームのname属性値を取得
    permitted_params = work_processes_params.to_h
    # フォームデータからIDを取得
    work_process_ids = permitted_params.keys
    # IDを指定してDBからデータ取得
    @work_processes = WorkProcess.where(id: work_process_ids)

    # success = true # フラグ初期化
    @work_processes.each do |work_process|
      # フォームデータからこのレコードに対応するパラメータを取得、idを文字列に変換
      update_record = permitted_params[work_process.id.to_s]

      # machine_assignments の更新処理
      if update_record.key?('machine_assignments')
        update_record['machine_assignments'].each do |assignment_id, assignment_params|
          assignment = work_process.machine_assignments.find(assignment_id)

          if assignment.update(assignment_params)
            flash.now[:alert] = "機械割り当ての更新に成功しました。"
          else
            flash.now[:alert] = "機械割り当ての更新に失敗しました。"
            render :edit_work_processes and return
          end
        end
        update_record.delete('machine_assignments')
      end

      # 更新処理を実行
      unless work_process.update(update_record)

        flash.now[:alert] = "作業工程の更新に失敗しました。"
        render :edit_work_processes and return
      end

    end
    # 更新後に並び替えを行う
    @work_processes = @work_processes.joins(:work_process_definition)
    .order("work_process_definitions.sequence ASC")

    redirect_to admin_order_path(@order), notice: "作業工程が更新されました。"
  end

  # 削除処理の開始し管理者削除を防ぐロジックはmodelで行う
  def destroy
    if @order.destroy
      # ココ(削除実行直前)でmodelに定義したコールバックが呼ばれる

      flash[:notice] = "発注が削除されました"
    else
      # バリデーションに失敗で@order.errors.full_messagesにエラーメッセージが配列として追加されます
      # .join(", "): 配列内の全てのエラーメッセージをカンマ区切り（, ）で連結
      flash[:alert] = @order.errors.full_messages.join(", ")
    end
    redirect_to admin_orders_path
  end

  private
  # フォームの入力値のみ許可
  def order_params
    params.require(:order).permit(
      :company_id,
      :product_number_id,
      :color_number_id,
      :roll_count,
      :quantity,
    )
  end

  def work_process_params
    params.require(:work_process).permit(
      :start_date, process_estimate: [:machine_type_id])
  end

  def set_order
    @order = Order.find(params[:id])
  end

  # 一般ユーザがアクセスした場合には一覧画面にリダイレクト
  def admin_user
    unless current_user&.admin?
      redirect_to orders_path, alert: "管理者以外アクセスできません"
    end
  end
end
