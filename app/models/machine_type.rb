class MachineType < ApplicationRecord
  has_many :machines
  has_many :process_estimates

  validates :name, presence: true, uniqueness: true
end
