class WorkProcessDefinition < ApplicationRecord
  has_many :process_estimates
  has_many :work_processes

  validates :name, presence: true
  validates :sequence, presence: true, uniqueness: true
end
