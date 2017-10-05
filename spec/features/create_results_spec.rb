feature 'Create Results', type: :feature do
  let!(:martinborough_2014) { FactoryGirl.create(:martinborough_2014_result) }
  let(:martinborough_race) { martinborough_2014.race }
  let(:user) { martinborough_2014.user }
  let!(:martinborough_2013) { FactoryGirl.create(:result_2013, race: martinborough_race, user: user) }

  before(:each) do
    login_as(user)
  end

  context 'Manual Form Entry' do
    scenario 'succeeds when unique' do
      click_link 'Results'
      click_link 'Add new Result'

      within('#manual') do
        select user.to_s, from: 'Rider'
        select martinborough_race.to_s, from: 'Race'

        fill_in 'Duration', with: '3:20:10'
        fill_in 'Date', with: '16 Jun 2016'
        fill_in 'Fastest Duration', with: '1:30:20'
        fill_in 'Median Duration', with: '2:10:30'
        fill_in 'Wind', with: '15'
        fill_in 'Position', with: '24'
        fill_in 'Finishers', with: '250'
        fill_in 'Timing URL', with: 'http://www.thetimingteam.co.nz/results'
        fill_in 'Strava URL', with: 'https://www.strava.com/activities/'
        fill_in 'Comment', with: 'Wet and windy'

        expect{ click_button 'Save' }.to change{Result.count}.by(1)
      end

      martinborough_2016 = Result.last

      click_link 'Results'
      click_link martinborough_2016.date.to_s

      within '.result-martinborough-charity-fun-ride-2016' do
        expect(page).to have_content('16 Jun 2016')
        expect(page).to have_content('3:20:10')
      end

      expect(martinborough_2016.duration).to eq (3.hours + 20.minutes + 10.seconds)
      expect(martinborough_2016.fastest_duration).to eq (1.hour + 30.minutes + 20.seconds)
      expect(martinborough_2016.median_duration).to eq (2.hours + 10.minutes + 30.seconds)
    end

    scenario 'fails when required fields not provided or incorrect format' do
      click_link 'Results'
      click_link 'Add new Result'

      within('#manual') do
        fill_in 'Duration', with: '123456'
        fill_in 'Fastest Duration', with: '123456'
        fill_in 'Median Duration', with: '123456'

        expect{ click_button 'Save' }.to_not change{Result.count}
      end

      expect(page).to have_content("Race can't be blank")
      expect(page).to have_content("Date can't be blank")
      expect(page).to have_content("Duration is not in the format 'h[h]:mm:ss'")
      expect(page).to have_content("Fastest Duration is not in the format 'h[h]:mm:ss'")
      expect(page).to have_content("Median Duration is not in the format 'h[h]:mm:ss'")
    end

    scenario 'fails when result for that race and year already exists' do
      visit result_path(martinborough_2014)
      click_link 'Edit'

      fill_in 'Date', with: martinborough_2013.date.to_s

      expect{ click_button 'Save' }.to_not change{martinborough_2014.updated_at}

      expect(page).to have_content('A Result by Dave Harris for Martinborough Charity Fun Ride in 2013 already exists')
    end
  end

  context 'Timing Team Import' do
    let(:timing_url) { 'http://www.thetimingteam.co.nz/results/index.php?thread=158411318&strand=1850252633&instance=5526' }
    let(:response) { File.read('spec/support/the_timing_team.html') }
    let(:all_results_response) { File.read('spec/support/the_timing_team_all.html') }

    before(:each) do
      stub_request(:get, timing_url).to_return(body: response)
      stub_request(:get, "#{timing_url}&cell=start").to_return(body: all_results_response)
    end

    context 'creation' do
      scenario 'creates a result' do
        visit results_path
        click_link 'Add new Result'
        click_link 'The Timing Team Import'

        within('#timing-team') do
          select martinborough_race.to_s, from: 'Race'
          fill_in 'The Timing Team URL', with: timing_url

          expect{ click_button 'Import' }.to change{Result.count}.by(1)
        end

        imported_race = Result.last
        expect(imported_race.race_id).to eq martinborough_race.id
        expect(imported_race.user_id).to eq user.id
        expect(imported_race.date).to eq Date.parse('1st Nov 15')
        expect(imported_race.wind).to eq '10'
        expect(imported_race.position).to eq 73
        expect(imported_race.finishers).to eq 156
        expect(imported_race.duration).to eq 12442
        expect(imported_race.fastest_duration).to eq 10272
        expect(imported_race.median_duration).to eq 12447
        expect(imported_race.slug).to eq 'martinborough-charity-fun-ride-2015'
        expect(imported_race.timing_url).to eq timing_url
      end
    end

    context 'enrichment' do
      let!(:minimal_result) { FactoryGirl.create(:minimal_result, date: '1 Nov 2015', race: martinborough_race, user: user, timing_url: timing_url) }

      scenario 'enriches the result' do
        visit result_path(minimal_result)
        click_link 'Edit'

        click_button 'Enrich from The Timing Team...'

        expect(minimal_result.reload.wind).to eq '10'
        expect(minimal_result.position).to eq 73
        expect(minimal_result.finishers).to eq 156
        expect(minimal_result.fastest_duration).to eq 10272
        expect(minimal_result.median_duration).to eq 12447
        expect(minimal_result.slug).to eq 'martinborough-charity-fun-ride-2015'
        expect(minimal_result.timing_url).to eq timing_url
      end
    end
  end

  context 'Strava Import' do
    let(:strava_url) { 'https://www.strava.com/activities/424029948' }
    let(:client) { double(:client) }
    let(:response) { JSON.parse(File.read('spec/support/strava_response.json')) }

    before(:each) do
      allow(Strava::Api::V3::Client).to receive(:new) { client }
      allow(client).to receive(:retrieve_an_activity) { response }
    end

    scenario 'creates a result from a URL' do
      visit results_path
      click_link 'Add new Result'
      click_link 'Strava Import'

      within('#strava') do
        select martinborough_race.to_s, from: 'Race'
        fill_in 'Strava Activity ID/URL', with: strava_url

        expect{ click_button 'Import' }.to change{Result.count}.by(1)
      end

      imported_race = Result.last
      expect(imported_race.race_id).to eq martinborough_race.id
      expect(imported_race.user_id).to eq user.id
      expect(imported_race.date).to eq Date.parse('1st Nov 15')
      expect(imported_race.slug).to eq 'martinborough-charity-fun-ride-2015'
      expect(imported_race.strava_url).to eq strava_url
    end

    scenario 'creates a result from an ID' do
      visit results_path
      click_link 'Add new Result'
      click_link 'Strava Import'

      within('#strava') do
        select martinborough_race.to_s, from: 'Race'
        fill_in 'Strava Activity ID/URL', with: '424029948'

        expect{ click_button 'Import' }.to change{Result.count}.by(1)
      end

      imported_race = Result.last
      expect(imported_race.date).to eq Date.parse('1st Nov 15')
      expect(imported_race.strava_url).to eq strava_url
    end
  end

  context 'CSV Bulk Upload' do
    scenario 'creates 2 results' do
      visit results_path
      click_link 'Add new Result'
      click_link 'CSV Bulk Upload'

      within('#csv') do
        attach_file('CSV File', 'spec/support/results.csv')

        expect{ click_button 'Upload CSV' }.to change{Result.count}.by(3)
      end

      imported_race = Result.last
      expect(imported_race.race.to_s).to eq "Tour of Waikanae (100km)"
      expect(imported_race.user_id).to eq user.id
      expect(imported_race.date).to eq Date.parse('12th Oct 14')
      expect(imported_race.slug).to eq 'tour-of-waikanae-100-2014'
    end
  end

end
