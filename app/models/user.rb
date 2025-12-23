class User < ApplicationRecord
  has_many :burritos, dependent: :destroy

  has_secure_password validations: false

  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true, on: :create
end
