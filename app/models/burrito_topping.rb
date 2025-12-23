class BurritoTopping < ApplicationRecord
  belongs_to :burrito
  belongs_to :topping
end
