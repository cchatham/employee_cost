class Employee < ApplicationRecord

  YEARLY_BASE_SALARY = 52000.freeze
  DEDUCTION = 1000.freeze

  # The table also check this. (See schema.) Doesn't cost much to double check.
  validates :name, presence: true 

  has_many :dependents
end
