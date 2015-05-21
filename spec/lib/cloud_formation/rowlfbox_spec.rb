require 'spec_helper'

RSpec.describe Runner::CloudFormation::Rowlfbox do
  describe "#create" do
    context "when rowlf.json template wasnt found" do
      it "raises exception" do
        allow(subject).to receive(:file) { "1234.rb" }

        expect { subject.create }.to raise_error(RuntimeError, "No rowlf.json file provided.")
      end
    end
  end
end