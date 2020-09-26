class Dependent < ApplicationRecord

  include Discount

  DEDUCTION = 500.freeze
  DISCOUNT_START_WITH = "a"

  # The table also check this. (See schema.) Doesn't cost much to double check.
  validates :name, presence: true 

  belongs_to :employee, counter_cache: true

  def deduction_amount
    DEDUCTION
  end
end
