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

end