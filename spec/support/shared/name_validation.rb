require 'spec_helper'

shared_examples_for 'name_validation' do |object|
  subject { object.valid? }


  describe "field validations" do
    let(:test_name) { "a valid name"}
    
    before do
      object.name = test_name
    end

    context "when valid name" do
      it "should be valid" do
        expect(subject).to eq(true)
      end
    end

    context "when invalid name" do
      let(:test_name) { nil }

      it "should not be valid" do
        expect(subject).to eq(false)
      end
    end
  end
end