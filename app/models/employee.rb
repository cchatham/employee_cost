class Employee < ApplicationRecord

  include Discount

  YEARLY_BASE_SALARY = 52000.freeze
  DEDUCTION = 1000.freeze

  # The table also check this. (See schema.) Doesn't cost much to double check.
  validates :name, presence: true 

  has_many :dependents

  # Allow dependents creation at the same time as the employee creation.
  accepts_nested_attributes_for :dependents, :reject_if => proc { |att| att[:name].blank? }

  def cost
    @cost ||= deduction + dependents_deduction
  end

  def adjusted_salary
    @adjusted_salary ||= YEARLY_BASE_SALARY - cost
  end

  def deduction_amount
    DEDUCTION
  end

  private

  def dependents_deduction
    dependents.map(&:deduction).inject(0, &:+)
  end
end
