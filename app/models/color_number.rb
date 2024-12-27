class ColorNumber < ApplicationRecord
  has_many :orders
  validates :color_code, presence: true, uniqueness: true
end
