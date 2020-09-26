class CreateEmployees < ActiveRecord::Migration[6.0]
  def change
    create_table :employees do |t|
      t.string :name, null: false
      t.integer :base_salary, null: false, default: 0
      t.integer :benefits_cost, null: false, default: 0
      t.integer :adjusted_salary, null: false, default: 0

      t.timestamps
    end
  end
end
