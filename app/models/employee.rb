class Employee < ApplicationRecord

  YEARLY_BASE_SALARY = 52000.freeze
  DEDUCTION = 1000.freeze
  DISCOUNT_START_WITH = "a"

  # The table also check this. (See schema.) Doesn't cost much to double check.
  validates :name, presence: true 

  has_many :dependents

  # Allow dependents creation at the same time as the employee creation.
  accepts_nested_attributes_for :dependents, :reject_if => proc { |att| att[:name].blank? }

  def adjusted_salary
    @adjusted_salary ||= YEARLY_BASE_SALARY - cost
  end

  def cost
    @cost ||= employee_deduction + dependents_deduction
  end

  def discount_eligible?
    name.downcase.start_with?(DISCOUNT_START_WITH)
  end

  private

  def apply_discount(number)
    number - (0.10 * number).floor.to_i
  end

  def employee_deduction
    return DEDUCTION unless discount_eligible?

    apply_discount(DEDUCTION)
  end

  def dependents_deduction
    #TODO database this?
    dependents_eligible_count = dependents.select { |d| d.discount_eligible? }.count

    return (dependents_eligible_count * apply_discount(Dependent::DEDUCTION)) 
      + ((dependents_count - dependents_eligible_count) * Dependent::DEDUCTION)
  end
end
