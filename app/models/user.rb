class User < ApplicationRecord
  belongs_to :company

  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :phone_number, presence: true
  validates :company_id, presence: true
  validates :password, presence: true, length: { minimum: 6 }
end
