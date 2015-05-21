require 'spec_helper'

RSpec.describe Runner::CloudFormation::EsCluster do
  describe "#create" do
    context "when elasticsearch-for-dotcom.json template wasnt found" do
      it "raises exception" do
        allow(subject).to receive(:file) { "1234.rb" }

        expect { subject.create }.to raise_error(RuntimeError, "No elasticsearch-for-dotcom.json file provided.")
      end
    end
  end
end