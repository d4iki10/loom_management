class ProcessEstimate < ApplicationRecord
  belongs_to :machine_type
  belongs_to :work_process_definition
  has_many :work_processes

  validates :earliest_completion_estimate, presence: true
  validates :latest_completion_estimate, presence: true
  validates :work_process_definition, presence: true

  private

  def self.machine_type_process_estimate(machine_type_id)
    if machine_type_id == 1
      where(id: 1..5)
    elsif machine_type_id == 2
      where(id: 6..10)
    else
      none # 該当なしの場合は空の結果を返す
    end
  end
end
