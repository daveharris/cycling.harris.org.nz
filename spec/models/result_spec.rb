describe Result do

  let(:result) { FactoryGirl.build(:result) }
  let(:user) { FactoryGirl.build(:user) }
  let(:race) { FactoryGirl.build(:race) }

  describe "validations" do
    it "is valid" do
      expect(result).to be_valid
    end

    it "is not valid without user" do
      result.user = nil
      expect(result).not_to be_valid
    end

    it "is not valid with duration in hh:mm:ss format" do
      result.duration = "5:36:27"
      expect(result).not_to be_valid
    end

    it "is not valid with negative duration" do
      result.duration = "-10"
      expect(result).not_to be_valid
    end

    it "is not valid with a non-integer number of seconds" do
      result.duration = "10.5"
      expect(result).not_to be_valid
    end
  end

  describe "#find_previous_result" do
    let(:race) { FactoryGirl.create(:race) }
    let(:other_race) { FactoryGirl.create(:race, name: 'Other Race') }

    let!(:result) { FactoryGirl.create(:result, race: race, date: Date.parse('2014-10-8')) }
    let!(:last_year) { FactoryGirl.create(:result, race: race, date: Date.parse('2013-10-5')) }

    before {
      FactoryGirl.create(:result, race: other_race, date: Date.parse('2013-10-5'))
      FactoryGirl.create(:result, race: race, date: Date.parse('2012-10-7'))
    }
    
    it "find last years result" do
      expect(result.find_previous_result).to eq last_year
    end
  end

  describe "#time_difference_between_previous" do
    let(:result) { FactoryGirl.build(:result, duration: 30) }

    it "returns a postive time difference if faster than last year" do
      allow(result).to receive_message_chain(:find_previous_result, :duration) { 40 }

      expect(result.time_difference_between_previous).to eq(10)
    end

    it "returns a negative time difference if slower than last year" do
      allow(result).to receive_message_chain(:find_previous_result, :duration) { 20 }
      
      expect(result.time_difference_between_previous).to eq(-10)
    end

    it "returns nil if previous result not found" do
      allow(result).to receive(:find_previous_result) { nil }
      
      expect(result.time_difference_between_previous).to be_nil
    end
  end

  describe ".from_csv" do
    let(:user) { FactoryGirl.create(:user) }

    before(:each) do
      Result.delete_all
      Result.from_csv(Rails.root.join("spec/support/results.csv"), user)
    end

    it "creates 2 distinct races" do
      expect(Race.count).to eq 2
    end

    it "creates 3 results" do
      expect(Result.count).to eq 3
    end

    it "assigns the results to the given user" do
      expect(user.results.count).to eq 3
    end

    it "sets the dates correctly" do
      expect(Result.last.date).to eq Date.parse('10/10/2010')
    end

    it "sets the duration in seconds" do
      expect(Result.last.duration).to eq ChronicDuration.parse('2:32:55')
    end
  end

  describe ".from_strava" do
    let(:client) { double(:client) }
    let(:json_response) { JSON.parse(File.read('spec/support/strava_response.json')) }

    before(:each) do
      allow(Strava::Api::V3::Client).to receive(:new) { client }
      allow(client).to receive(:retrieve_an_activity) { json_response }
      allow(Result).to receive(:create!)
    end

    context "activity_id is a full strava url" do
      it "splits the id from the url" do
        expect(client).to receive(:retrieve_an_activity).with('123') { json_response }
        Result.from_strava('http://www.strava.com/activities/123', race.id, user)
      end
    end

    it "sets the duration" do
      expect(Result).to receive(:create!).with(hash_including(duration: 13388))
      Result.from_strava('123', race.id, user)
    end

    it "sets the date" do
      expect(Result).to receive(:create!).with(hash_including(date: Date.parse("2014-11-16")))
      Result.from_strava('123', race.id, user)
    end

    it "sets the comment" do
      expect(Result).to receive(:create!).with(hash_including(comment: 'Windy, partly wet. Stayed with the same bunch all the way around'))
      Result.from_strava('123', race.id, user)
    end

    it "sets the strava_url" do
      expect(Result).to receive(:create!).with(hash_including(strava_url: 'http://www.strava.com/activities/123'))
      Result.from_strava('123', race.id, user)
    end
  end

  describe ".from_timing_team" do
    let(:response) { File.read('spec/support/timing_team.html') }

    before(:each) do
      allow(self).to receive(:open) { response }
      allow(Result).to receive(:create!)
    end

    after(:each) do
      Result.from_timing_team('http://www.thetimingteam.co.nz/results/index.php?thread=2121579998&strand=1187175897&instance=3349', race.id, user)
    end

    { duration: 18752, 
      date: Date.parse("2014-11-29"), 
      wind: '24', position: '1070', 
      finishers: '3612', 
      timing_url: 'http://www.thetimingteam.co.nz/results/index.php?thread=2121579998&strand=1187175897&instance=3349', 
      fastest_duration: 14748, 
      mean_duration: 20824
    }.each do |key, value|
      it "sets the #{key}" do
        expect(Result).to receive(:create!).with(hash_including(key => value))
      end    
    end
  end
end
