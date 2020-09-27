desc "Update existing employee to populate new counter cache for dependents."
task :update_dependents_counter_cache => :environment do
  Employee.all.each do |employee|
    employee.dependents_count = employee.dependents.count
    employee.save!
  end
end