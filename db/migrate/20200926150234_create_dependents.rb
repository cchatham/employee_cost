class CreateDependents < ActiveRecord::Migration[6.0]
  def change
    create_table :dependents do |t|
      t.string :name, null: false
      t.belongs_to :employee, foreign_key: true

      t.timestamps
    end
  end
end
