class ProductNumber < ApplicationRecord
  has_many :orders

  validates :number, presence: true, uniqueness: true
end
