class MachineStatus < ApplicationRecord
  has_many :machine_assignments

  validates :name, presence: true, uniqueness: true
end
