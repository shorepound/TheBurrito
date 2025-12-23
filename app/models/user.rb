class User < ApplicationRecord
  has_many :burritos, dependent: :destroy

  has_secure_password

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :first_name, length: { maximum: 50 }, allow_blank: true
  validates :last_name, length: { maximum: 50 }, allow_blank: true
  validates :password, length: { minimum: 6 }, allow_nil: true
end

