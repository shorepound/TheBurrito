class Filling < ApplicationRecord
  has_many :burrito_fillings, dependent: :destroy
  has_many :burritos, through: :burrito_fillings
  validates :name, presence: true, uniqueness: true
end
