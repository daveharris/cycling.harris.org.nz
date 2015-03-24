require 'spec_helper'

describe ResultDecorator do
  let(:result) { FactoryGirl.create(:result, duration_s: "2:00:00").decorate }

  before do
    allow(result).to receive(:find_previous_result) { previous }
  end

  describe "#previous_time_difference" do
    context "when difference is nil" do
      let(:previous) { nil }

      it "returns 'First Result' text" do
        expect(result.previous_time_difference(:duration)).to match(/First Result/)
      end
    end

    context "when difference is positive" do
      let(:previous) { FactoryGirl.build(:result, race: result.race, duration_s: "3:00:00") }

      it "returns 'faster' text" do
        expect(result.previous_time_difference(:duration)).to match(/faster/)
      end
    end

    context "when difference is negative" do
      let(:previous) { FactoryGirl.build(:result, race: result.race, duration_s: "1:00:00") }

      it "returns 'slower' text" do
        expect(result.previous_time_difference(:duration)).to match(/slower/)
      end
    end
  end

end