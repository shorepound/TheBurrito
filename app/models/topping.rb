class Topping < ApplicationRecord
  has_many :burrito_toppings, dependent: :destroy
  has_many :burritos, through: :burrito_toppings
  validates :name, presence: true, uniqueness: true
end
