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
  
  describe "#display_time_difference_in_words" do
    context "when difference is nil" do
      it "returns 'First Result' text" do
        expect(helper.display_time_difference_in_words(nil)).to match(/First Result/)
      end
    end

    context "when difference is positive" do
      it "returns 'faster' text" do
        expect(helper.display_time_difference_in_words(10)).to match(/faster/)
      end
    end

    context "when difference is negative" do
      it "returns 'slower' text" do
        expect(helper.display_time_difference_in_words(-10)).to match(/slower/)
      end
    end
    
  end
end