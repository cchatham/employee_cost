require 'spec_helper'

shared_examples_for 'discount' do
  let(:object) { described_class.new(name: test_name) }
  let(:test_name) { "random" }

  describe ".discount_eligible?" do
    subject { object.discount_eligible? }

    context "when name does not start with a or A" do
      it "should return false" do
        expect(subject).to eq(false)
      end
    end

    context "when name starts with a" do
      let(:test_name) { "and" }

      it "should return false" do
        expect(subject).to eq(true)
      end
    end

    context "when name does not start with A" do
      let(:test_name) { "Ajfkdsl" }

      it "should return false" do
        expect(subject).to eq(true)
      end
    end

    context "when it doesn't respond to name" do
      let(:object) { described_class.new }

      it "should return false" do
        expect(object).to receive(:respond_to?).with(:name).and_return(false)
        expect(subject).to eq(false)
      end
    end
  end

  describe ".deduction" do 
    subject { object.deduction }

    context "when deduction amount is not defined" do
      let(:object) { described_class.new }

      it "should raise an error" do
        expect(object).to receive(:respond_to?).with(:deduction_amount).and_return(false)
        expect { subject }.to raise_error(StandardError)
      end
    end

    context "when not eligible" do
      let(:stubbed_deduction) { 100 }

      it "should return default" do
        expect(object).to receive(:discount_eligible?).and_return(false)
        expect(object).to receive(:deduction_amount).and_return(stubbed_deduction)
        expect(subject).to eq(stubbed_deduction)
      end
    end

    context "when eligible" do
      let(:stubbed_deduction) { 100 }
      let(:expected_deduction) { 90 }

      it "take 10% off the default" do
        expect(object).to receive(:discount_eligible?).and_return(true)
        expect(object).to receive(:deduction_amount).and_return(stubbed_deduction)
        expect(subject).to eq(expected_deduction)
      end
    end
  end
end