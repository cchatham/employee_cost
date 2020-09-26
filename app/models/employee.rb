class Employee < ApplicationRecord

  YEARLY_BASE_SALARY = 52000.freeze
  DEDUCTION = 1000.freeze

  # The table also check this. (See schema.) Doesn't cost much to double check.
  validates :name, presence: true 

  has_many :dependents

  # Allow dependents creation at the same time as the employee creation.
  accepts_nested_attributes_for :dependents, :reject_if => proc { |att| att[:name].blank? }

  def adjusted_salary
    @adjusted_salary ||= YEARLY_BASE_SALARY - cost
  end

  def cost
    #TODO dont run a count query for every employee. Preload the count somehow.
    @cost ||= DEDUCTION + (dependents_count * Dependent::DEDUCTION)
  end
end
