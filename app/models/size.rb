class Size < ApplicationRecord
  has_many :burritos
  validates :name, presence: true, uniqueness: true
end
