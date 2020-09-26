class Dependent < ApplicationRecord

  DEDUCTION = 500.freeze

  # The table also check this. (See schema.) Doesn't cost much to double check.
  validates :name, presence: true 

  belongs_to :employee, counter_cache: true
end
