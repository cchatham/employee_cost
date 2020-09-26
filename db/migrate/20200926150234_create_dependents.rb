class CreateDependents < ActiveRecord::Migration[6.0]
  def change
    create_table :dependents do |t|
      t.string :name, null: false
      
      t.timestamps
    end

    # This assumes that the employees table exists 
    # which generally is safe if the migrations are run in order.
    add_foreign_key :dependents, :employees
  end
end
