require 'rails_helper'
require 'support/concerns/discount'
require 'support/shared/name_validation'

RSpec.describe Dependent, type: :model do

  it_behaves_like "discount"
  it_should_behave_like "name_validation", described_class.new(employee: Employee.new(name: "employee"))

  it "have one employee" do
    should respond_to(:employee)
  end

  # Ensure counter cache for employee
  describe "creation" do
    subject { described_class.create(name: "abc", employee: create_employee) }

    let(:create_employee) { Employee.create(name: "parent") }

    it "creates one dependent" do
      expect { subject } .to change { Dependent.count }.by(1)
    end

    it "increases the counter cache on the parent" do
      expect { subject } .to change { create_employee.reload.dependents_count }.by(1)
    end
  end
end
