class WorkProcessStatus < ApplicationRecord
  has_many :work_processes
  validates :name, presence: true, uniqueness: true
end
