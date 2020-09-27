module Discount
  extend ActiveSupport::Concern

  DISCOUNT_START_WITH = "a"

  def discount_eligible?
    return false unless self.respond_to?(:name)

    name.downcase.start_with?(DISCOUNT_START_WITH)
  end

  def deduction
    raise StandardError.new("Deduction definition is required.") unless self.respond_to?(:deduction_amount)
    return deduction_amount unless discount_eligible?
  
    apply_discount(deduction_amount)
  end

  private

  def apply_discount(number)
    number - (0.10 * number).floor.to_i
  end
end