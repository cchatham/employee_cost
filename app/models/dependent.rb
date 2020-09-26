class Dependent < ApplicationRecord

  DEDUCTION = 500.freeze
  DISCOUNT_START_WITH = "a"

  # The table also check this. (See schema.) Doesn't cost much to double check.
  validates :name, presence: true 

  belongs_to :employee, counter_cache: true

  #TODO database side instead?
  def discount_eligible?
    name.downcase.start_with?(DISCOUNT_START_WITH)
  end
end
