class AddCounterCacheToEmployees < ActiveRecord::Migration[6.0]
  def change
    add_column :employees, :dependents_count, :integer, default: 0, null: false
  end
end
