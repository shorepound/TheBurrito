class Burrito < ApplicationRecord
  belongs_to :user
  belongs_to :tortilla
  belongs_to :size

  has_many :burrito_fillings, dependent: :destroy
  has_many :fillings, through: :burrito_fillings

  has_many :burrito_toppings, dependent: :destroy
  has_many :toppings, through: :burrito_toppings

  validates :user, :tortilla, :size, presence: true
end
