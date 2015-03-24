describe ApplicationHelper do

  describe "#duration_in_words" do
    it "converts seconds to hours:mins:seconds" do
      expect(helper.duration_in_words(3600)).to eq "1:00:00"
    end
  end

  describe "#date_in_words" do
    it "converts the date to day month year" do
      expect(helper.date_in_words(Date.parse('2014-10-15'))).to eq "15th Oct 14"
    end
  end
  
  describe "#personal_best_time_difference" do
    let(:result) { double(:result, duration: 200, find_personal_best: previous) }

    context "when difference is 0" do
      let(:previous) { double(:result, duration: 200) }

      it "returns 'First Result' text" do
        expect(helper.personal_best_time_difference(result)).to match(/Personal Best/)
      end
    end

    context "when difference is negative" do
      let(:previous) { double(:result, duration: 100) }

      it "returns 'slower' text" do
        expect(helper.personal_best_time_difference(result)).to match(/slower/)
      end
    end
    
  end
end