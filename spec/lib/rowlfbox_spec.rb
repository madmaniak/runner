require 'spec_helper'

RSpec.describe Runner::Rowlfbox do
  describe "#create" do
    context "when rowlf.json template wasnt found" do
      it "raises exception" do
        box = Runner::Rowlfbox.new
        allow(box).to receive(:file) { "1234.rb" }

        expect { box.create }.to raise_error(RuntimeError, "No rowlf.json file provided.")
      end
    end
  end
end