require 'rails_helper'
require 'support/concerns/discount'
require 'support/shared/name_validation'

RSpec.describe Employee, type: :model do

  it_behaves_like "discount"
  it_should_behave_like "name_validation", described_class.new
  
  it "has many dependents" do
    should respond_to(:dependents)
  end

  describe "accepts_nested_attributes_for dependents" do
    subject { described_class.create(create_params) }
    
    let(:create_params) { 
      {
        name: "This is a test.",
        dependents_attributes: {
          "0": { name: "d1" },
          "1": { name: "" }
        }
      }
    }

    it "creates the employee" do
      expect { subject }.to change { Employee.count }.by(1)
    end

    it "creates one dependent" do
      expect { subject } .to change { Dependent.count }.by(1)
    end
  end

  describe ".cost" do
    subject { object.cost }
    
    let(:d1) { Dependent.new(name: "d1") }
    let(:d1_deduction) { 1 }
    let(:d2) { Dependent.new(name: "d2") }
    let(:d2_deduction) { 2 }
    let(:object) { described_class.new(name: "employee") }
    let(:object_deduction) { 10 } 
    let(:object_dependents) { [d1, d2] }
    let(:expected_result) { 13 }

    it "should add up employee and all dependents deduction cost" do
      expect(d1).to receive(:deduction).and_return(d1_deduction)
      expect(d2).to receive(:deduction).and_return(d2_deduction)
      expect(object).to receive(:deduction).and_return(object_deduction)
      expect(object).to receive(:dependents).and_return(object_dependents)
      expect(subject).to eq(expected_result)
    end
  end

  describe ".adjusted_salary" do
    subject { object.adjusted_salary }
    
    let(:object) { described_class.new(name: "employee") }
    let(:stubbed_cost) { 1000 }
    let(:expected_result) { described_class::YEARLY_BASE_SALARY - stubbed_cost }

    it "should subtract the cost from the yearly base salary" do
      expect(object).to receive(:cost).and_return(stubbed_cost)
      expect(subject).to eq(expected_result)
    end
  end
end
