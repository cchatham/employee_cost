class EmployeesController < ApplicationController
  def index
    @new_employee = Employee.new
    5.times { @new_employee.dependents.new }
    @new_dependents = @new_employee.dependents
    @employees = Employee.includes(:dependents).all
  end

  def create
    @employee = Employee.create(create_params)
    # Go to index to simulate a single page app but it's not. 
    # This refreshes the page so that the employee shows up in table.
    if @employee.save
      redirect_to employees_url
    else
      redirect_to employees_url, flash: { error: @employee.errors.full_messages.join(', ') }
    end
  end

  private

  def create_params
    params.require(:employee).permit(:name, dependents_attributes: :name).tap do |employee_params|
      employee_params.require(:name)
    end
  end
end
