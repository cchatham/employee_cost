class RemoveSalaryInfoFromEmployees < ActiveRecord::Migration[6.0]
  def change
    remove_column :employees, :base_salary
    remove_column :employees, :benefits_cost
    remove_column :employees, :adjusted_salary
  end
end
