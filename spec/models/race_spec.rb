describe Race do
  let(:race) { FactoryGirl.build(:race) }

  describe "validations" do
    it "is valid" do
      expect(race).to be_valid
    end

    it "is invalid without name" do
      race.name = nil
      expect(race).to_not be_valid
    end

    it "is invalid without distance" do
      race.distance = nil
      expect(race).to_not be_valid
    end

    context "uniqueness" do
      let!(:race) { FactoryGirl.create(:race) }
      let(:race2) { FactoryGirl.build(:race) }

      it "is invalid with the same name and distance" do
        expect(race2).to_not be_valid
      end

      it "is valid with the same name but different distance" do
        race2.distance = 10
        expect(race2).to be_valid
      end
    end
  end

  describe "to_s" do
    it "concatenates the name and distance" do
      expect(race.to_s).to eq 'Test Cycle Race (1km)'
    end
  end

  describe "result_duration_over_time" do
    let(:race) { FactoryGirl.create(:race) }
    let!(:result1) { FactoryGirl.create(:result, race: race) }
    let!(:result2) { FactoryGirl.create(:result, race: race, date: '2014-10-16', duration_s: "5:00:00", fastest_duration_s: "4:00:00", median_duration_s: "6:00:00") }

    it "gathers race results into time and duration" do
      results_data = [["15 Oct 2014", 5400, 3600, 7200], ["16 Oct 2014", 18000, 14400, 21600]]
      expect(race.result_duration_over_time).to eq results_data
    end
  end

end