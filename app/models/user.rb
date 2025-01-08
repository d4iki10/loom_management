class User < ApplicationRecord
  belongs_to :company

  has_secure_password

  validates :name, presence: true
  validates :email, uniqueness: true
  validates :company_id, presence: true
  validates :password, presence: true, length: { minimum: 6 }
end
